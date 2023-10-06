import 'package:flutter/material.dart';
import 'package:programming_show/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class ShowTodoScreen extends StatelessWidget {
  const ShowTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Programming show')),
        body: FutureBuilder(
            future:
                Provider.of<TodoProvider>(context, listen: false).selectTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<TodoProvider>(
                  builder: (context, todoProvider, child) {
                    return todoProvider.todoItem.isNotEmpty
                        ? ListView.builder(
                            itemCount: todoProvider.todoItem.length,
                            itemBuilder: (context, index) {
                              return const ListTile();
                            })
                        : const Center(
                            child: Text(
                            'List has no data',
                            style: TextStyle(fontSize: 35, color: Colors.black),
                          ));
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
