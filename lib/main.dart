import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad/features/editor/presentation/controllers/app_controller.dart';
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
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.teal,
            selectionHandleColor: Colors.teal,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.teal,
            selectionHandleColor: Colors.teal,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const AppController(),
      ),
    );
  }
}
