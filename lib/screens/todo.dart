import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Map<String, String>> tasks = [
    {'task': 'Desligar as luzes que não estão em uso', 'value': '5 kWh/mês'},
    {'task': 'Usar lâmpadas de baixo consumo', 'value': '15 kWh/mês'},
    {'task': 'Lavar roupas com água fria', 'value': '20 kWh/mês'},
    {'task': 'Usar um termostato programável', 'value': '25 kWh/mês'},
    {'task': 'Lavar roupas com água fria', 'value': '20 kWh/mês'},
    {'task': 'Usar um termostato programável', 'value': '25 kWh/mês'},
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
            subtitle: Text('Economiza: ${tasks[index]['value']}'),
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
