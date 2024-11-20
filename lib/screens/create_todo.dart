import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final List<String> _todos = [];
  final TextEditingController _controller = TextEditingController();
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'ecogame.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, savings INTEGER, done INTEGER)',
        );
      },
      version: 1,
    );
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final List<Map<String, dynamic>> maps = await _database.query('tasks');
    setState(() {
      _todos.clear();
      _todos.addAll(maps.map((task) => task['title'].toString()).toList());
    });
  }

  Future<void> _addTodo() async {
    if (_controller.text.isNotEmpty) {
      await _database.insert(
        'tasks',
        {'title': _controller.text, 'savings': 0, 'done': 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      setState(() {
        _todos.add(_controller.text);
        _controller.clear();
      });
    }
  }

  Future<void> _deleteTodo(int index) async {
    await _database.delete(
      'tasks',
      where: 'title = ?',
      whereArgs: [_todos[index]],
    );
    setState(() {
      _todos.removeAt(index);
    });
  }

  Future<void> _editTodoDialog(BuildContext context, int index) async {
    _controller.text = _todos[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Tarefa'),
          content: TextField(
            controller: _controller,
            decoration:
                const InputDecoration(hintText: 'Entrar com nova tarefa'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _database.update(
                  'tasks',
                  {'title': _controller.text},
                  where: 'title = ?',
                  whereArgs: [_todos[index]],
                );
                setState(() {
                  _todos[index] = _controller.text;
                  _controller.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                _controller.clear();
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
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Adicionar Tarefa',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ),
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
