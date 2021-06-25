from playhouse.shortcuts import model_to_dict
from todoapp import db
from peewee import BooleanField, ForeignKeyField, Model, CharField

class BaseModel(Model):
  class Meta:
    database = db
  
  def to_json(self):
    return model_to_dict(self)

class Category(BaseModel):
  category = CharField()

class Todo(BaseModel):
  title = CharField()
  completed = BooleanField()
  category = ForeignKeyField(Category, backref='todos')