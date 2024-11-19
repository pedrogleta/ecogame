import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({super.key});

  final List<Map<String, String>> tasks = [
    {'task': 'Turn off lights when not in use', 'value': '5 kWh/month'},
    {'task': 'Unplug devices when not in use', 'value': '10 kWh/month'},
    {'task': 'Use energy-efficient light bulbs', 'value': '15 kWh/month'},
    {'task': 'Wash clothes with cold water', 'value': '20 kWh/month'},
    {'task': 'Use a programmable thermostat', 'value': '25 kWh/month'},
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
            subtitle: Text('Saves: ${tasks[index]['value']}'),
          );
        },
      ),
    );
  }
}
