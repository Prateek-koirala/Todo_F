import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ToDo(),
      theme: ThemeData(primarySwatch: Colors.yellow, useMaterial3: false),
    );
  }
}
