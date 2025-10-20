import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tab_provider.dart';
import '../widgets/tab_bar_widget.dart';
import '../widgets/keyboard_shortcut_handler.dart';
import '../utils/super_editor_stylesheets.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_markdown/super_editor_markdown.dart';

/// Main page with tabbed editor interface
class TabbedEditorPage extends StatefulWidget {
  const TabbedEditorPage({super.key});

  @override
  State<TabbedEditorPage> createState() => _TabbedEditorPageState();
}

class _TabbedEditorPageState extends State<TabbedEditorPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return KeyboardShortcutHandler(
      child: Scaffold(
        body: Column(
          children: [
            // Tab bar
            const TabBarWidget(),
            // Editor area
            Expanded(
              child: Consumer<TabProvider>(
                builder: (context, tabProvider, child) {
                  final activeTab = tabProvider.activeTab;

                  if (activeTab == null) {
                    return const Center(child: Text('No tabs available'));
                  }

                  return SuperEditor(
                    editor: activeTab.editor,
                    stylesheet: isDarkMode
                        ? SuperEditorStylesheets().darkStylesheet
                        : SuperEditorStylesheets().lightStylesheet,
                    selectionStyle: SelectionStyles(
                      selectionColor: Theme.of(context).colorScheme.primary,
                    ),
                    plugins: {MarkdownInlineUpstreamSyntaxPlugin()},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
