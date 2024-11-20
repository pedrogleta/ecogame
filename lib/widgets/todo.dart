import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ecogame/models/todo.dart';

class TodoList extends StatefulWidget {
  final List<Todo> tasks;
  final Future<void> Function() updateTasks;
  const TodoList({super.key, required this.tasks, required this.updateTasks});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<bool> _completed = [];

  @override
  void initState() {
    super.initState();
    _completed = List<bool>.filled(widget.tasks.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              widget.tasks[index].title,
              style: const TextStyle(
                decoration:
                    // _completed[index] ? TextDecoration.lineThrough : null,
                    TextDecoration.lineThrough,
              ),
            ),
            subtitle: Text('Economiza: ${widget.tasks[index].savings} kWh/mês'),
            trailing: Checkbox(
              value:
                  // _completed[index],
                  widget.tasks[index].done,
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
