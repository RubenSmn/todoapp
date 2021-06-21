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
  final List<TodoItem> _todoList = <TodoItem>[
    TodoItem(
      title: 'test1',
      category: 'home',
    ),
    TodoItem(
      title: 'test2',
      category: 'home',
    ),
    TodoItem(
      title: 'test3',
      category: 'home',
    ),
  ];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildTodoList(),
            ),
          ],
        ),
      ),
      // body: Container(
      //   child: Padding(
      //     padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      //     child: Column(
      //       children: [
      //         // Padding(
      //         //   padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      //         //   child: Text(
      //         //     'TodoList',
      //         //     style: TextStyle(
      //         //       fontSize: 20,
      //         //     ),
      //         //   ),
      //         // ),
      //         Text(
      //           'TodoList',
      //           style: TextStyle(
      //             fontSize: 20,
      //           ),
      //         ),
      //         SizedBox(
      //           height: 300,
      //           child: ListView(
      //             children: _getItems(),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title, String category) {
    setState(() {
      _todoList.add(TodoItem(
        title: title,
        category: category,
      ));
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
            child: Column(
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
                // Icon
              ],
            ),
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
