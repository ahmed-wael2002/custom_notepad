import 'package:flutter/material.dart';
import 'package:notepad/features/editor/presentation/widgets/editor_widget.dart';

class EditorScreen extends StatelessWidget {
  final bool isDarkMode;
  const EditorScreen({super.key, this.isDarkMode = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditorWidget(isDarkMode: isDarkMode));
  }
}
