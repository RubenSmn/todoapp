from flask import request
from flask_restful import Resource
from todoapp.models import Todo, Category

class TodoController(Resource):
  def get(self):
    todos = Todo.select()
    if not todos:
      return {'message': 'No todos found', 'data': []}, 200
    todos = [todo.to_json() for todo in todos]
    return {'message': 'Succes', 'data': todos}, 200

  def post(self):
    data = request.json
    if not 'title' in data.keys():
      return {'message': 'Invalid data', 'data': {}}, 400
    Todo.create(
      title=data['title'],
      completed=data['completed'],
      category=data['category'],
    )
    return {'message': 'Todo created', 'data': {}}, 200


class CategoryController(Resource):
  def get(self):
    categories = Category.select()
    if not categories:
      return {'message': 'No categories found', 'data': []}, 200
    categories = [category.to_json() for category in categories]
    return {'message': 'Succes', 'data': categories}, 200
  
  def post(self):
    data = request.json
    if not 'category' in data.keys():
      return {'message': 'Invalid data', 'data': {}}, 400
    Category.create(
      category=data['category']
    )
    return {'message': 'Category created', 'data': {}}, 200