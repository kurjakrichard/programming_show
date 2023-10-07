import 'package:flutter/material.dart';
import 'package:programming_show/provider/todo_provider.dart';
import 'package:programming_show/screens/add_todo_screen.dart';
import 'package:provider/provider.dart';

class ShowTodoScreen extends StatelessWidget {
  const ShowTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Programming show')),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddTodoScreen()));
          },
        ),
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
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  style: ListTileStyle.drawer,
                                  title:
                                      Text(todoProvider.todoItem[index].title),
                                  subtitle: Text(todoProvider
                                          .todoItem[index].description ??
                                      ''),
                                  trailing:
                                      Text(todoProvider.todoItem[index].date),
                                ),
                              );
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
