from flask_restful import Resource, reqparse 
from todoapp.models import Todo, Category

post_parser = reqparse.RequestParser()
post_parser.add_argument(
  'title',
  required=True,
  type=str
)
post_parser.add_argument(
  'category',
  required=True,
  type=str
)

put_parser = reqparse.RequestParser()
put_parser.add_argument(
  'id',
  required=True,
  type=int
)
put_parser.add_argument(
  'completed',
  required=True,
  type=bool
)

class TodoController(Resource):
  def get(self):
    todos = Todo.select(Todo)
    if not todos:
      return {'message': 'No todos found', 'data': []}, 200
    todos = [todo.to_json() for todo in todos]
    return {'message': 'Succes', 'data': todos}, 200

  def post(self):
    args = post_parser.parse_args()
    category, created = Category.get_or_create(
      category=args['category']
    )
    Todo.create(
      title=args['title'],
      category=category.id,
    )
    return {'message': 'Todo created', 'data': {}}, 200
  
  def put(self):
    args = put_parser.parse_args()
    todo = Todo.get_by_id(args['id'])
    todo.completed = args['completed']
    todo.save()
    return {'mesasge': 'Todo updated'}, 200

