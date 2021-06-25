from flask_restful import Resource
from todoapp.models import Category

class CategoryController(Resource):
  def get(self):
    categories = Category.select()
    if not categories:
      return {'message': 'No categories found', 'data': []}, 200
    categories = [category.to_json() for category in categories]
    return {'message': 'Succes', 'data': categories}, 200