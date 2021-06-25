from enum import unique
from playhouse.shortcuts import model_to_dict
from todoapp import db
from peewee import BooleanField, DateTimeField, ForeignKeyField, Model, CharField
import datetime

class BaseModel(Model):
  class Meta:
    database = db
  
  def to_json(self):
    return model_to_dict(self)

class Category(BaseModel):
  category = CharField(unique=True)
  created_at = DateTimeField(deafult=datetime.datetime.now)

class Todo(BaseModel):
  title = CharField()
  completed = BooleanField()
  category = ForeignKeyField(Category, backref='todos')
  deleted = BooleanField(default=False)
  created_at = DateTimeField(deafult=datetime.datetime.now)
  updated_at = DateTimeField(deafult=datetime.datetime.now)