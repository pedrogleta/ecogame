import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Map<String, String>> tasks = [
    {'task': 'Desligar as luzes que não estão em uso', 'value': '5'},
    {'task': 'Usar lâmpadas de baixo consumo', 'value': '15'},
    {'task': 'Lavar roupas com água fria', 'value': '20'},
    {'task': 'Usar um termostato programável', 'value': '25'},
    {'task': 'Lavar roupas com água fria', 'value': '20'},
    {'task': 'Usar um termostato programável', 'value': '25'},
  ];

  final List<bool> _completed = List<bool>.filled(6, false);

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
              tasks[index]['task']!,
              style: TextStyle(
                decoration:
                    _completed[index] ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text('Economiza: ${tasks[index]['value']} kWh/mês'),
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
