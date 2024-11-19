import 'package:flutter/material.dart';
import 'package:ecogame/widgets/todo.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final double _energyCost = 0.13;

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
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                height: 300.0,
                child: TodoList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
