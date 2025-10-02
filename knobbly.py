
from flask import Flask, render_template, request, redirect, url_for, flash
from config import config
from werkzeug.security import generate_password_hash
from flask_mysqldb import MySQL
from models.entities.User import User
from models.ModelUser import ModelUser
from flask_login import LoginManager, login_user, login_user, logout_user, login_required


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

knobblyApp.route('/signup', methods=['GET', 'POST'])
def signup():
        if request.method == 'POST':
            nombre = request.form['nombre']
            correo = request.form['correo']
            clave = request.form['clave']
            claveCifrada = generate_password_hash(clave)
            regUsuario = db.connection.cursor()
            regUsuario.execue("INSERT INTO usuario(nombre,correo,clave) VALUES (%s, %s, %s)", (nombre, correo, clave))
            db.connection.commit()
            return redirect(url_for('home'))

# Iniciar sesion
@knobblyApp.route('/signin',methods=['GET', 'POST'])
def signin():
    if request.method == "POST":
        usuario= User(0,None, request.form['correo'], request.form['clave'], None)
        usuarioAutenticado = ModelUser.signin(db, usuario)
        if usuarioAutenticado is not None:
            if usuarioAutenticado.clave:
                login_user(usuarioAutenticado)
                if usuarioAutenticado.perfil == 'A':
                    return render_template('admin.html')
                else:
                    return render_template('user.html')
            else:
                flash('clave incorrecta')
                return redirect(request.url)
        else:
            flash('usuario inexistente')
            return redirect(request.url)
    else:
        return render_template('signin.html')

@knobblyApp.route('/signout', methods=['GET','POST'])
def signout():
    logout_user()
    return redirect(url_for('home'))

@knobblyApp.route('/sUsuario', methods=['GET','POST'])
def sUsuario():
    SelUsuario = db.connection.cursor()
    SelUsuario.execute("SELECT * FROM usuario")
    u = SelUsuario.fetchall()
    return render_template('users.html', usuarios = u)

if __name__ == '__main__':
    knobblyApp.config.from_object(config['development'])
    knobblyApp.run(port=7007)



