import 'package:flutter/material.dart';
import 'package:ecogame/models/todo.dart';

class TodoList extends StatefulWidget {
  final List<Todo> tasks;
  final Future<void> Function() updateTasks;
  const TodoList({super.key, required this.tasks, required this.updateTasks});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
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
              style: TextStyle(
                decoration: widget.tasks[index].done
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Text('Economiza: ${widget.tasks[index].savings} kWh/mês'),
            trailing: Checkbox(
              value: widget.tasks[index].done,
              onChanged: (bool? value) {},
            ),
          );
        },
      ),
    );
  }
}
