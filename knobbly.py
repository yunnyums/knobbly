from flask import Flask, render_template, url_for

knobblyApp = Flask(__name__)

@knobblyApp.route('/')
def home():
    return render_template('home.hmtl')

if __name__ == '__main__':
    knobblyApp.run(debug=True,port=7007)