// lib/screens/add_todo/add_todo_screen.dart

import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  String selectedCategory = 'Personal';
  DateTime selectedDate = DateTime.now();

  List<String> categories = ['Personal', 'Work', 'Health', 'Study'];

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // yahan todo model create karo aur back bhejo
      Navigator.pop(context, {
        'title': _titleController.text,
        'category': selectedCategory,
        'date': selectedDate,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title input
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Todo Title'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter title' : null,
              ),

              SizedBox(height: 16),

              // Category dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map((cat) =>
                    DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Category'),
              ),

              SizedBox(height: 16),

              // Date picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Pick Date'),
                  ),
                ],
              ),

              Spacer(),

              // Add button
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add Todo',style: TextStyle(fontSize: 21,color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
