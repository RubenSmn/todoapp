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
    category, created = Category.get_or_create(
      category=data['category']
    )
    Todo.create(
      title=data['title'],
      completed=data['completed'],
      category=category.id,
    )
    return {'message': 'Todo created', 'data': {}}, 200


class CategoryController(Resource):
  def get(self):
    categories = Category.select()
    if not categories:
      return {'message': 'No categories found', 'data': []}, 200
    categories = [category.to_json() for category in categories]
    return {'message': 'Succes', 'data': categories}, 200