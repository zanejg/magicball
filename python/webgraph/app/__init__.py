import os
import json

from flask import Flask
from flask import render_template

from .accel import accelerometer



def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass
    
    acc = accelerometer()
    

    # a simple page that says hello
    @app.route('/')
    def index():
        return render_template('rolling_graph.html')
    @app.route('/getdata/')
    def getdata():
        #return json.dumps(acc.get_accel())
        return json.dumps(acc.get_gyro())

    return app

