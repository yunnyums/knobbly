from models.entities.User import User
from werkzeug.security import check_password_hash

class ModelUser:

    @classmethod
    def signin(self, db, usuario):
        try:
            cursor = db.connection.cursor()
            cursor.execute("SELECT id, nombre, correo, clave, perfil FROM usuario WHERE correo = %s", (usuario.correo,))
            u = cursor.fetchone()
            cursor.close()

            if u is None:
                return None

            id = u[0]
            nombre = u[1]
            correo = u[2]
            clave_cifrada = u[3]
            perfil = u[4]          # <-- AQUÍ SE OBTIENE EL PERFIL REAL

            # validar contraseña
            if not check_password_hash(clave_cifrada, usuario.clave):
                return None

            # devolver usuario con perfil correcto
            return User(id, nombre, correo, clave_cifrada, perfil)

        except Exception as ex:
            raise Exception(ex)


    @classmethod
    def get_by_id(self, db, id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("SELECT id, nombre, correo, clave, perfil FROM usuario WHERE id = %s", (id,))
            u = cursor.fetchone()
            cursor.close()

            if u is None:
                return None

            return User(u[0], u[1], u[2], u[3], u[4])  # <-- PERFIL INCLUIDO

        except Exception as ex:
            raise Exception(ex)
