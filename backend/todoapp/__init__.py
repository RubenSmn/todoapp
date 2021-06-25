from flask import Flask
from flask_restful import Api
from peewee import SqliteDatabase

# Init app/api
app = Flask(__name__)
api = Api(app, prefix='/api')

# Init database
db = SqliteDatabase('test.db')

# Init tables
from todoapp.models import Todo, Category
db.create_tables([Todo, Category])

# Add Controllers to api
from todoapp.routes import TodoController, CategoryController
api.add_resource(TodoController, '/todos')
api.add_resource(CategoryController, '/categories')