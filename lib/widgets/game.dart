import 'package:flutter/material.dart';
import 'package:ecogame/widgets/todo.dart';
import 'package:ecogame/models/todo.dart';

class Game extends StatefulWidget {
  final List<Todo> tasks;
  final Future<void> Function() updateTasks;
  final Future<void> Function(int, bool) updateTaskDone;
  const Game(
      {super.key,
      required this.tasks,
      required this.updateTasks,
      required this.updateTaskDone});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final double _energyCost = 0.57;

  double _calculateTotalSavings() {
    return widget.tasks
        .where((task) => task.done)
        .map((task) => task.savings * _energyCost)
        .fold(0.0, (sum, savings) => sum + savings);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Preço atual da energia',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'R\$$_energyCost/kWh',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16.0) +
                const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 300.0,
                child: TodoList(
                    tasks: widget.tasks,
                    updateTasks: widget.updateTasks,
                    updateTaskDone: widget.updateTaskDone),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Economia Total',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'R\$${_calculateTotalSavings().toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
