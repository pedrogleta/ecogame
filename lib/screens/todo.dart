import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({super.key});

  final List<Map<String, String>> tasks = [
    {'task': 'Desligar as luzes que não estão em uso', 'value': '5 kWh/mês'},
    {'task': 'Usar lâmpadas de baixo consumo', 'value': '15 kWh/mês'},
    {'task': 'Lavar roupas com água fria', 'value': '20 kWh/mês'},
    {'task': 'Usar um termostato programável', 'value': '25 kWh/mês'},
    {'task': 'Lavar roupas com água fria', 'value': '20 kWh/mês'},
    {'task': 'Usar um termostato programável', 'value': '25 kWh/mês'},
  ];

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
            title: Text(tasks[index]['task']!),
            subtitle: Text('Economiza: ${tasks[index]['value']}'),
          );
        },
      ),
    );
  }
}
