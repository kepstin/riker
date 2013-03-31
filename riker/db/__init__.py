# -*- coding: utf-8 -*-

import sqlalchemy
import sqlalchemy.orm
from riker import config

engine = None
Session = sqlalchemy.orm.session.sessionmaker()

def open(application = None):
    if not application:
        application = 'DEFAULT'
    engine = sqlalchemy.create_engine(config.get(application, 'database'), echo=True)
    Session.configure(bind = engine)
    
