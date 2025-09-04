from flask import Flask, render_template, request, redirect, url_for
from config import config
from werkzeug.security import generate_password_hash
from flask_mysqldb import MySQL
from models.entities.User import user
from models.ModelUser import ModelUser
from flask_login import LoginManager, login_user, login_user

# Configuración de Flask y MySQL
knobblyApp = Flask(__name__)
knobblyApp.config.from_object(config['development'])
db = MySQL(knobblyApp)
signinManager = LoginManager(knobblyApp)

@signinManager.user_loader
def loader_user(id):
    return ModelUser.get_by_id(db, id)

# Página principal
@knobblyApp.route('/')
def home():
    return render_template('home.html')

# Iniciar sesión
@knobblyApp.route('/signin', methods=["GET", "POST"])
def signin():
    if request.method == "POST":
        correo = request.form.get("correo")
        clave = request.form.get("clave")
        # Aquí iría la lógica para verificar usuario y contraseña
        print(f"Iniciar sesión con: {correo}, {clave}")
        return redirect(url_for("home"))
    return render_template('signin.html')

# Registrarse
@knobblyApp.route('/signup', methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        nombre = request.form.get("nombre")
        correo = request.form.get("correo")
        clave = request.form.get("clave")
        telefono = request.form.get("telefono")
        direccion = request.form.get("direccion")

        # Validación básica
        if not nombre or not correo or not clave or not telefono or not direccion:
            return "Faltan datos en el formulario", 400
        
        # Cifrar contraseña
        claveCifrada = generate_password_hash(clave)
        perfil = 'U'  # Valor por defecto

        # Depuración
        print("Datos a insertar:", nombre.upper(), correo, claveCifrada, telefono, direccion, perfil)

        # Guardar usuario en la base de datos
        cursor = db.connection.cursor()
        cursor.execute(
            "INSERT INTO usuario (nombre, correo, clave, telefono, direccion, perfil) VALUES (%s, %s, %s, %s, %s, %s)",
            (nombre.upper(), correo, claveCifrada, telefono, direccion, perfil)
        )
        db.connection.commit()
        cursor.close()

        return redirect(url_for("signin"))

    return render_template('signup.html')

# Ejecutar la app
if __name__ == '__main__':
    knobblyApp.run(debug=True,port=7007)


@knobblyApp.route('/')
def home():
    return render_template('home.hmtl')

