# -*- coding: utf-8 -*-

import sqlalchemy
from riker import config

engine = None

def open(application = None):
    if not application:
        application = 'DEFAULT'
    engine = sqlalchemy.create_engine(config.get(application, 'database'), echo=True)
