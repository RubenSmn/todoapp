from enum import unique
from playhouse.shortcuts import model_to_dict
from todoapp import db
from peewee import BooleanField, DateTimeField, ForeignKeyField, Model, CharField
import datetime

class BaseModel(Model):
  class Meta:
    database = db
  
  def to_json(self):
    model = model_to_dict(self)
    model['created_at'] = model['created_at'].strftime("%m/%d/%Y, %H:%M:%S")
    return model

class Category(BaseModel):
  category = CharField(unique=True)
  created_at = DateTimeField(default=datetime.datetime.now)

class Todo(BaseModel):
  title = CharField()
  completed = BooleanField(default=False)
  category = ForeignKeyField(Category, backref='todos')
  deleted = BooleanField(default=False)
  created_at = DateTimeField(default=datetime.datetime.now)
  updated_at = DateTimeField(default=datetime.datetime.now)

  def to_json(self):
    model = super().to_json()
    model['updated_at'] = model['updated_at'].strftime("%m/%d/%Y, %H:%M:%S")
    model['category'] = model['category']['category']
    return model 