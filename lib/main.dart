import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo_provider.dart';
import 'package:my_todo_app/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TodoProvider(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
