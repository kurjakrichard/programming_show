import 'package:flutter/material.dart';
import 'package:programming_show/model/todo.dart';
import 'package:programming_show/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: ListView(
        children: [
          textController('Title', _titleController),
          textController('Description', _descriptionController),
          textController('Date', _dateController),
          ElevatedButton(
              onPressed: () {
                Todo todo = Todo(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    date: _dateController.text);
                Provider.of<TodoProvider>(context, listen: false)
                    .insertTodo(todo);
                //context.read<TodoProvider>().insertTodo(todo);
                clerControllers();
                Navigator.pop(context);
              },
              child: const Text('Insert'))
        ],
      ),
    );
  }

  void clerControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  Widget textController(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), hintText: title),
      ),
    );
  }
}
