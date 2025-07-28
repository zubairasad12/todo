import 'package:flutter/material.dart';
import '../../models/todo_model.dart';
import '../../widgets/todo_tile.dart';
import '../add_todo/add_todo_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int selectedFilterIndex = 0; // 0: All, 1: Pending, 2: Completed
  List<String> filters = ["All", "Pending", "Completed"];
  List<TodoModel> todos = [
    TodoModel(
      id: '1',
      title: 'Buy groceries',
      category: 'Personal',
      date: DateTime.now(),
      isCompleted: false,
    ),
    TodoModel(
      id: '2',
      title: 'Submit report',
      category: 'Work',
      date: DateTime.now().subtract(Duration(days: 1)),
      isCompleted: true,
    ),
    TodoModel(
      id: '3',
      title: 'Go for a walk',
      category: 'Health',
      date: DateTime.now(),
      isCompleted: false,
    ),
  ];

  List<TodoModel> get filteredTodos {
    if (selectedFilterIndex == 0) {
      return todos;
    } else if (selectedFilterIndex == 1) {
      return todos.where((todo) => !todo.isCompleted).toList();
    } else {
      return todos.where((todo) => todo.isCompleted).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO App"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips Row
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(filters[index]),
                    selected: selectedFilterIndex == index,
                    onSelected: (value) {
                      setState(() {
                        selectedFilterIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Todo List
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = filteredTodos[index];

                return TodoTile(
                  todo: todo,
                  onChanged: (value) {
                    setState(() {
                      todo.isCompleted = value!;
                    });
                  },
                  onDelete: () {
                    setState(() {
                      todos.removeWhere((t) => t.id == todo.id);
                    });
                  },
                );
              },
            ),
          ),

        ],
      ),

      // ✅ Correct Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              todos.add(TodoModel(
                id: DateTime.now().toString(),
                title: result['title'],
                category: result['category'],
                date: result['date'],
                isCompleted: false,
              ));
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
