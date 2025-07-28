// lib/models/todo_model.dart

class TodoModel {
  final String id;
  final String title;
  final String category;
  final DateTime date;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    this.isCompleted = false,
  });
}
