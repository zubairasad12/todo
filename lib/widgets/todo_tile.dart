import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete; // 👈 NEW

  const TodoTile({
    required this.todo,
    required this.onChanged,
    required this.onDelete, // 👈 NEW
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: onChanged,
          shape: CircleBorder(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          "${todo.category} • ${todo.date.day}/${todo.date.month}/${todo.date.year}",
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete, // 👈 Connect kar diya
        ),
      ),
    );
  }
}
