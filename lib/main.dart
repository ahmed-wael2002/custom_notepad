import 'package:flutter/material.dart';
import 'package:notepad/features/editor/presentation/pages/editor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: EditorScreen(
        isDarkMode: Theme.of(context).brightness == Brightness.dark,
      ),
    );
  }
}
