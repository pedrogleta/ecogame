class Todo {
  final int id;
  final String title;
  final int savings;
  final bool done;

  Todo({
    required this.id,
    required this.title,
    required this.savings,
    required this.done,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      savings: json['savings'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'savings': savings,
      'done': done,
    };
  }
}
