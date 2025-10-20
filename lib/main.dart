import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notepad/features/editor/presentation/pages/tabbed_editor_page.dart';
import 'package:notepad/features/editor/presentation/providers/tab_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TabProvider(),
      child: MaterialApp(
        title: 'Notepad',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const TabbedEditorPage(),
      ),
    );
  }
}
