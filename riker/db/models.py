# -*- coding: utf-8 -*-

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String

Base = declarative_base()

class File(Base):
    __tablename__ = 'files'
    
    id = Column(Integer, primary_key = True)
    uri = Column(String)
