from flask import Flask

knobblyApp = Flask(__name__)

@knobblyApp.route('/')
def home():
    return '<h1> Hola mundo!</h1>'

if __name__ == '__main__':
    knobblyApp.run(debug=True,port=7007)