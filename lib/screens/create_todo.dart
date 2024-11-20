import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CreateTodoScreen extends StatefulWidget {
  final Database database;
  final Future<void> Function() updateTasks;
  const CreateTodoScreen(
      {super.key, required this.database, required this.updateTasks});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final List<String> _todos = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _savingsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final List<Map<String, dynamic>> maps =
        await widget.database.query('tasks');
    setState(() {
      _todos.clear();
      _todos.addAll(maps.map((task) => task['title'].toString()).toList());
    });
  }

  Future<void> _addTodo() async {
    if (_controller.text.isNotEmpty && _savingsController.text.isNotEmpty) {
      await widget.database.insert(
        'tasks',
        {
          'title': _controller.text,
          'savings': int.parse(_savingsController.text),
          'done': 0
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      setState(() {
        _todos.add(_controller.text);
        _controller.clear();
        _savingsController.clear();
      });
      widget.updateTasks();
    }
  }

  Future<void> _deleteTodo(int index) async {
    await widget.database.delete(
      'tasks',
      where: 'title = ?',
      whereArgs: [_todos[index]],
    );
    setState(() {
      _todos.removeAt(index);
    });
    widget.updateTasks();
  }

  Future<void> _editTodoDialog(BuildContext context, int index) async {
    _controller.text = _todos[index];
    final List<Map<String, dynamic>> maps = await widget.database.query(
      'tasks',
      where: 'title = ?',
      whereArgs: [_todos[index]],
    );
    _savingsController.text = maps.first['savings'].toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'Entrar com nova tarefa'),
              ),
              TextField(
                controller: _savingsController,
                decoration:
                    const InputDecoration(hintText: 'Economia (kWh/mês)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await widget.database.update(
                  'tasks',
                  {
                    'title': _controller.text,
                    'savings': int.parse(_savingsController.text)
                  },
                  where: 'title = ?',
                  whereArgs: [_todos[index]],
                );
                setState(() {
                  _todos[index] = _controller.text;
                  _controller.clear();
                  _savingsController.clear();
                });
                Navigator.of(context).pop();
                widget.updateTasks();
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                _controller.clear();
                _savingsController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Tarefas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Adicionar Tarefa',
                  ),
                ),
                TextField(
                  controller: _savingsController,
                  decoration: const InputDecoration(
                    labelText: 'Economia (kWh/mês)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Adicionar Tarefa'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todos[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editTodoDialog(context, index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTodo(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
