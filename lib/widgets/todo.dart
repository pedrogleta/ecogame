import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, String>> tasks = [];
  List<bool> _completed = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final database = openDatabase(join(await getDatabasesPath(), 'ecogame.db'),
        onCreate: (db, version) => db.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, savings INTEGER, done INTEGER)',
            ),
        version: 1);

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    setState(() {
      tasks = List.generate(maps.length, (i) {
        return {
          'title': maps[i]['title'],
          'savings': maps[i]['savings'].toString(),
        };
      });
      _completed = List<bool>.filled(tasks.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tasks[index]['title']!,
              style: TextStyle(
                decoration:
                    _completed[index] ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text('Economiza: ${tasks[index]['savings']} kWh/mês'),
            trailing: Checkbox(
              value: _completed[index],
              onChanged: (bool? value) {
                setState(() {
                  _completed[index] = value ?? false;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
