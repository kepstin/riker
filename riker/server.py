# -*- coding: utf-8 -*-

import sqlalchemy
import flask

import db

db.open('server')

from db.models import *

app = flask.Flask(__name__)

@app.before_request
def before_request():
    flask.g.db = db.Session()

@app.after_request
def after_request(response):
    flask.g.db.close()
    return response

@app.route('/')
def hello_world():
    return 'Hello, World!'

test_file = File(uri = 'file:///example.mp3')
