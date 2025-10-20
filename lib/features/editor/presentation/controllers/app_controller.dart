import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tab_provider.dart';
import '../pages/homepage.dart';
import '../pages/tabbed_editor_page.dart';

/// Main app controller that manages the overall app state
/// Follows clean architecture by separating presentation logic
class AppController extends StatelessWidget {
  const AppController({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, tabProvider, child) {
        // Show homepage when there are no tabs
        if (tabProvider.tabs.isEmpty) {
          return const Homepage();
        }

        // Show tabbed editor when there are tabs
        return const TabbedEditorPage();
      },
    );
  }
}
