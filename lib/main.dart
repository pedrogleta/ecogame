import 'package:ecogame/widgets/game.dart';
import 'package:flutter/material.dart';
import 'package:ecogame/screens/create_todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ecogame/models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoGame',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00e6f0af)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EcoGame'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database _database;
  List<Todo> _tasks = [];

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
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final List<Map<String, dynamic>> maps = await _database.query('tasks');
    setState(() {
      _tasks = List.generate(maps.length, (i) {
        return Todo(
          id: maps[i]['id'],
          title: maps[i]['title'],
          savings: maps[i]['savings'],
          done: maps[i]['done'] == 1,
        );
      });
    });
  }

  Future<void> _updateTasks() async {
    _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7E8D5),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Game(tasks: _tasks, updateTasks: _updateTasks),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateTodoScreen(
                    database: _database, updateTasks: _updateTasks)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
