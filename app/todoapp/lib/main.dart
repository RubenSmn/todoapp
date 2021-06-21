import 'package:flutter/material.dart';
import 'package:todoapp/themes/theme.dart';

import 'TodoItem.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        // primarySwatch: AppTheme.colors.blue,
        scaffoldBackgroundColor: AppTheme.colors.blue[800],
        primaryColor: AppTheme.colors.blue[800],
        accentColor: AppTheme.colors.yellow,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();
  final List<TodoItem> _todoList = <TodoItem>[
    TodoItem(
      title: 'test1',
      category: 'home',
      done: false,
    ),
    TodoItem(
      title: 'test2',
      category: 'home',
      done: false,
    ),
    TodoItem(
      title: 'test3',
      category: 'home',
      done: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'TodoList',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: _buildTodoList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showTodoDialog(context);
        },
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showTodoDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.colors.blue,
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _textEditingController,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Can't be empty";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter something todo",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addTodoItem(_textEditingController.text, 'test');
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addTodoItem(String title, String category) {
    setState(() {
      _todoList.add(
        TodoItem(
          title: title,
          category: category,
          done: false,
        ),
      );
    });
    _textEditingController.clear();
  }

  Widget _buildTodoItem(TodoItem todoItem) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 85,
          color: AppTheme.colors.blue,
          child: Padding(
            padding: EdgeInsets.all(21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoItem.title,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      todoItem.category,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    todoItem.done
                        ? Icons.check_circle_outline
                        : Icons.circle_outlined,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      todoItem.done = !todoItem.done;
                    });
                  },
                  color: todoItem.done ? AppTheme.colors.yellow : Colors.white,
                ),
              ],
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       todoItem.title,
            //       style: TextStyle(
            //         fontSize: 22,
            //       ),
            //     ),
            //     Text(
            //       todoItem.category,
            //       style: TextStyle(
            //         fontSize: 16,
            //       ),
            //     ),
            //     Icon(
            //       todoItem.done
            //           ? Icons.check_circle_outline
            //           : Icons.circle_outlined,
            //       color: todoItem.done ? AppTheme.colors.yellow : null,
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
      margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _todoList.length,
      itemBuilder: (context, i) {
        return _buildTodoItem(_todoList[i]);
      },
    );
  }
}
