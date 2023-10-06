import 'package:flutter/material.dart';
import 'package:programming_show/provider/todo_provider.dart';
import 'package:programming_show/screens/show_todo_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TodoProvider())],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Programming show',
        theme: ThemeData(),
        home: const ShowTodoScreen(),
      ),
    );
  }
}
