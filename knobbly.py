from flask import Flask, render_template, request, redirect, url_for, flash
from config import config
from werkzeug.security import generate_password_hash
from flask_mysqldb import MySQL
from models.entities.User import User
from models.ModelUser import ModelUser
from flask_login import LoginManager, login_user, logout_user, login_required, current_user

# ----------------------------------------
# Configuración de Flask y MySQL
# ----------------------------------------
knobblyApp = Flask(__name__)
knobblyApp.config.from_object(config['development'])
db = MySQL(knobblyApp)

# ----------------------------------------
# LoginManager
# ----------------------------------------
signinManager = LoginManager(knobblyApp)
signinManager.login_view = 'signin'

@signinManager.user_loader
def loader_user(id):
    return ModelUser.get_by_id(db, id)

# ----------------------------------------
# Página principal
# ----------------------------------------
@knobblyApp.route('/')
def home():
    return render_template('home.html')

# ----------------------------------------
# Registro
# ----------------------------------------
@knobblyApp.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        claveCifrada = generate_password_hash(clave)

        cursor = db.connection.cursor()
        cursor.execute(
            "INSERT INTO usuario(nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)",
            (nombre, correo, claveCifrada, "U")   # PERFIL POR DEFECTO: USUARIO
        )
        db.connection.commit()
        cursor.close()

        flash('Registro exitoso. Ya puedes iniciar sesión.')
        return redirect(url_for('signin'))

    return render_template('signup.html')

# ----------------------------------------
# Inicio de Sesión
# ----------------------------------------
@knobblyApp.route('/signin', methods=['GET', 'POST'])
def signin():
    if request.method == 'POST':
        correo = request.form['correo']
        clave = request.form['clave']

        usuario = User(0, None, correo, clave, None)
        usuarioAutenticado = ModelUser.signin(db, usuario)

        if usuarioAutenticado:
            login_user(usuarioAutenticado)

            # Redirección por PERFIL
            if usuarioAutenticado.perfil == 'A':
                return redirect(url_for('admin'))
            else:
                return redirect(url_for('user'))

        flash("Correo o contraseña incorrectos")
        return redirect(url_for('signin'))

    return render_template('signin.html')

# ----------------------------------------
# Cerrar Sesión
# ----------------------------------------
@knobblyApp.route('/signout')
@login_required
def signout():
    logout_user()
    flash('Sesión cerrada correctamente.')
    return redirect(url_for('home'))
# ----------------------------------------
# ADMIN (solo administradores)
# ----------------------------------------
@knobblyApp.route('/admin')
@login_required
def admin():
    cursor = db.connection.cursor()

    # USUARIOS
    cursor.execute("SELECT id, nombre, correo, perfil FROM usuario")
    usuarios = cursor.fetchall()

    # PEDIDOS
    cursor.execute("""
        SELECT p.id, u.nombre, p.fecha, p.total
        FROM pedidos p
        JOIN usuario u ON p.usuario_id = u.id
    """)
    pedidos = cursor.fetchall()

    cursor.close()

    return render_template('admin.html', usuarios=usuarios, pedidos=pedidos)

@knobblyApp.route('/admin/usuario/editar', methods=['POST'])
@login_required
def admin_editar_usuario():
    if current_user.perfil != "A":
        return redirect('/')

    id = request.form['id']
    nombre = request.form['nombre']
    correo = request.form['correo']
    perfil = request.form['perfil']

    cursor = db.connection.cursor()
    cursor.execute("""
        UPDATE usuario SET nombre=%s, correo=%s, perfil=%s WHERE id=%s
    """, (nombre, correo, perfil, id))
    db.connection.commit()
    cursor.close()

    flash("Usuario actualizado correctamente")
    return redirect('/admin')

# ----------------------------------------
# Productos
# ----------------------------------------
@knobblyApp.route('/productos')
@login_required
def productos():
    cur = db.connection.cursor()
    cur.execute("SELECT id, nombre_producto, descripcion, precio, Imagen FROM productos")
    data = cur.fetchall()

    columnas = [col[0] for col in cur.description]
    productos = [dict(zip(columnas, row)) for row in data]

    return render_template('productos.html', productos=productos)


#agregar al carrito
@knobblyApp.route('/agregar_carrito/<int:id>')
@login_required
def agregar_carrito(id):
    cur = db.connection.cursor()
    cur.execute("""
        INSERT INTO carrito (usuario_id, producto_id, cantidad)
        VALUES (%s, %s, 1)
    """, (current_user.id, id))
    db.connection.commit()
    cur.close()

    return redirect(url_for('productos'))


    # Revisar si ya está ese producto en el carrito
    cursor.execute("""
        SELECT id, cantidad FROM carrito
        WHERE usuario_id=%s AND producto_id=%s
    """, (current_user.id, id))
    item = cursor.fetchone()

    if item:
        # Actualizar cantidad
        cursor.execute("""
            UPDATE carrito SET cantidad = cantidad + %s
            WHERE id=%s
        """, (cantidad, item[0]))
    else:
        # Insertar nuevo producto
        cursor.execute("""
            INSERT INTO carrito (usuario_id, producto_id, cantidad)
            VALUES (%s, %s, %s)
        """, (current_user.id, id, cantidad))

    db.connection.commit()
    cursor.close()

    flash("Producto agregado al carrito 🛒", "success")
    return redirect('/productos')
@knobblyApp.route('/carrito')
@login_required
def carrito():
    cursor = db.connection.cursor()
    cursor.execute("""
        SELECT c.id, p.nombre_producto, p.precio, c.cantidad, p.imagen
        FROM carrito c
        JOIN productos p ON c.producto_id = p.id
        WHERE c.usuario_id = %s
    """, (current_user.id,))
    
    carrito = cursor.fetchall()
    cursor.close()

    total = sum((item[2] * item[3]) for item in carrito)

    return render_template('carrito.html', carrito=carrito, total=total)
@knobblyApp.route('/finalizar_compra', methods=['POST'])
@login_required
def finalizar_compra():
    cursor = db.connection.cursor()

    # Obtener carrito
    cursor.execute("""
    SELECT c.producto_id, c.cantidad, p.precio
    FROM carrito c
    JOIN productos p ON c.producto_id = p.id
    WHERE c.usuario_id=%s
        """, (current_user.id,))
    items = cursor.fetchall()


    if not items:
        flash("Tu carrito está vacío", "warning")
        return redirect('/carrito')

    total = sum(i[1] * i[2] for i in items)

    # Crear pedido
    cursor.execute("""
        INSERT INTO pedidos (usuario_id, total)
        VALUES (%s, %s)
    """, (current_user.id, total))
    pedido_id = cursor.lastrowid

    # Insertar detalles
    for prod_id, cantidad, precio in items:
        cursor.execute("""
            INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario)
            VALUES (%s, %s, %s, %s)
        """, (pedido_id, prod_id, cantidad, precio))


    # Vaciar carrito
    cursor.execute("DELETE FROM carrito WHERE usuario_id=%s", (current_user.id,))

    db.connection.commit()
    cursor.close()

    flash("Compra realizada con éxito 🐾🛒", "success")
    return redirect('/mis_pedidos')
@knobblyApp.route('/mis_pedidos')
@login_required
def mis_pedidos():
    cursor = db.connection.cursor()
    cursor.execute("""
        SELECT id, fecha, total
        FROM pedidos
        WHERE usuario_id = %s
        ORDER BY fecha DESC
    """, (current_user.id,))
    pedidos = cursor.fetchall()
    cursor.close()

    return render_template('pedidos.html', pedidos=pedidos)

#user 
@knobblyApp.route('/user')
@login_required
def user():
    cursor = db.connection.cursor()
    cursor.execute("SELECT id, usuario_id, nombre_gato, edad, raza, descripcion FROM perfiles_gatos")
    gatos = cursor.fetchall()
    cursor.close()

    return render_template('user.html', gatos=gatos)

# ----------------------------------------
# Listado de Usuarios
# ----------------------------------------
@knobblyApp.route('/sUsuario')
@login_required
def sUsuario():
    cursor = db.connection.cursor()
    cursor.execute("SELECT * FROM usuario")
    usuarios = cursor.fetchall()
    cursor.close()
    return render_template('users.html', usuarios=usuarios)

# ----------------------------------------
# Insertar Usuario Manual
# ----------------------------------------
@knobblyApp.route('/iUsuario', methods=['POST'])
def iUsuario():
    nombre = request.form['nombre']
    correo = request.form['correo']
    clave = generate_password_hash(request.form['clave'])
    perfil = request.form['perfil']

    cursor = db.connection.cursor()
    cursor.execute(
        "INSERT INTO usuario (nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)",
        (nombre, correo, clave, perfil)
    )
    db.connection.commit()
    cursor.close()

    flash('Cuenta creada correctamente')
    return redirect(url_for("sUsuario"))

# ----------------------------------------
# Ejecutar Aplicación
# ----------------------------------------
if __name__ == '__main__':
    knobblyApp.config.from_object(config['development'])
    knobblyApp.run(port=7007, debug=True)