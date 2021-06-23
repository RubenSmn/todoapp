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

  String? _filterCategory = 'all';
  // Might need to find a better way of doing this
  List<String> _dropdownCategories = [];
  List<String> _getDropdownCategories() {
    var list = _todoList.map((t) => t.category).toSet().toList();
    return list;
  }

  _HomePageState() {
    _dropdownCategories = _getDropdownCategories();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Text(
                      'TodoList',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Container(
                    child: DropdownButton<String>(
                      value: _filterCategory,
                      dropdownColor: AppTheme.colors.blue,
                      items: <String>[
                        'all',
                        ..._dropdownCategories,
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        'choose a category',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _filterCategory = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: _buildTodoList(false),
                    color: AppTheme.colors.blue[700],
                  ),
                  Container(
                    child: _buildTodoList(true),
                    color: AppTheme.colors.blue[700],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.circle_outlined),
            ),
            Tab(
              icon: Icon(Icons.check_circle_outline),
            )
          ],
          labelColor: AppTheme.colors.yellow,
          unselectedLabelColor: AppTheme.colors.blue[100],
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: AppTheme.colors.yellow,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _showTodoDialog(context);
          },
          tooltip: 'Add task',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  _dropdownCategories = _getDropdownCategories();
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
          ),
        ),
      ),
      margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
    );
  }

  Widget _buildTodoList(status) {
    var list = [];
    if (status == null)
      list = _todoList;
    else if (status)
      list = _todoList.where((t) => t.done).toList();
    else
      list = _todoList.where((t) => !t.done).toList();

    if (_filterCategory != 'all')
      list = list.where((t) => t.category == _filterCategory).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, i) {
        return _buildTodoItem(list[i]);
      },
    );
  }
}
