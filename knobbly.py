from flask import Flask, render_template, request, redirect, url_for, flash
from config import config
from werkzeug.security import generate_password_hash
from flask_mysqldb import MySQL
from models.entities.User import User
from models.ModelUser import ModelUser
from flask_login import LoginManager, login_user, logout_user, login_required

# Configuración de Flask y MySQL
knobblyApp = Flask(__name__)
knobblyApp.config.from_object(config['development'])
db = MySQL(knobblyApp)

# Configurar LoginManager
signinManager = LoginManager(knobblyApp)
signinManager.login_view = 'signin'  # Redirige a signin si no hay sesión

# Cargar usuario
@signinManager.user_loader
def loader_user(id):
    return ModelUser.get_by_id(db, id)

# Página principal
@knobblyApp.route('/')
def home():
    return render_template('home.html')

# Registrarse
@knobblyApp.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        claveCifrada = generate_password_hash(clave)

        cursor = db.connection.cursor()
        cursor.execute(
            "INSERT INTO usuario(nombre, correo, clave) VALUES (%s, %s, %s)",
            (nombre, correo, claveCifrada)
        )
        db.connection.commit()
        flash('Registro exitoso. Ahora puedes iniciar sesión.')
        return redirect(url_for('signin'))
    else:
        return render_template('signup.html')

# Iniciar sesión
@knobblyApp.route('/signin', methods=['GET', 'POST'])
def signin():
    if request.method == 'POST':
        correo = request.form['correo']
        clave = request.form['clave']

        usuario = User(0, None, correo, clave, None)
        usuarioAutenticado = ModelUser.signin(db, usuario)

        if usuarioAutenticado is not None:
            if usuarioAutenticado.clave: 
                login_user(usuarioAutenticado)
                if usuarioAutenticado.perfil == 'A':
                    return render_template('admin.html')
                else:
                    SelProductos = db.connection.cursor()
                    SelProductos.execute("SELECT * FROM productos")
                    p = SelProductos.fetchall()
                    return render_template('productos.html', productos = p)
            else:
                flash('Clave incorrecta')
                return redirect(request.url)
        else:
            flash('Usuario inexistente')
            return redirect(request.url)
    else:
        return render_template('signin.html')

# Cerrar sesión
@knobblyApp.route('/signout')
@login_required
def signout():
    logout_user()
    flash('Sesión cerrada correctamente.')
    return redirect(url_for('home'))

# Listar usuarios (solo ejemplo)
@knobblyApp.route('/sUsuario')
@login_required
def sUsuario():
    cursor = db.connection.cursor()
    cursor.execute("SELECT * FROM usuario")
    usuarios = cursor.fetchall()
    return render_template('users.html', usuarios=usuarios)

@knobblyApp.route('/sProductos')
@login_required
def sProductos():
    SelProductos = db.connection.cursor()
    SelProductos.execute("SELECT * FROM productos")
    p = SelProductos.fetchall()
    return render_template('productos.html', productos = p)

@knobblyApp.route('/iUsuario', methods=['POST', 'GET'])
def iUsuario():
    nombre = request.form['nombre']
    correo = request.form['correo']
    clave = request.form['clave']
    perfil = request.form['perfil']
    insUsuario = db.connection.cursor()
    insUsuario.execute("INSERT INTO usuario (nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)",(nombre, correo, clave, perfil))
    db.connection.commit()
    insUsuario.close()
    flash('Cuenta creada')
    return redirect(url_for("sUsuario"))

# Punto de entrada
if __name__ == '__main__':
    knobblyApp.config.from_object(config['development'])
    knobblyApp.run(port=7007, debug=True)
