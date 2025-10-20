import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/tab_provider.dart';

/// Widget that handles keyboard shortcuts for the editor
class KeyboardShortcutHandler extends StatelessWidget {
  final Widget child;

  const KeyboardShortcutHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        // Ctrl+T for new tab
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyT):
            _NewTabIntent(),
        // Ctrl+W for close tab
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyW):
            _CloseTabIntent(),
        // Ctrl+Tab for next tab
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.tab):
            _NextTabIntent(),
        // Ctrl+Shift+Tab for previous tab
        LogicalKeySet(
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.tab,
        ): _PreviousTabIntent(),
        // Ctrl+S for save file
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
            _SaveFileIntent(),
        // Ctrl+O for open file
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO):
            _OpenFileIntent(),
      },
      child: Actions(
        actions: {
          _NewTabIntent: CallbackAction<_NewTabIntent>(
            onInvoke: (_) => _handleNewTab(context),
          ),
          _CloseTabIntent: CallbackAction<_CloseTabIntent>(
            onInvoke: (_) => _handleCloseTab(context),
          ),
          _NextTabIntent: CallbackAction<_NextTabIntent>(
            onInvoke: (_) => _handleNextTab(context),
          ),
          _PreviousTabIntent: CallbackAction<_PreviousTabIntent>(
            onInvoke: (_) => _handlePreviousTab(context),
          ),
          _SaveFileIntent: CallbackAction<_SaveFileIntent>(
            onInvoke: (_) => _handleSaveFile(context),
          ),
          _OpenFileIntent: CallbackAction<_OpenFileIntent>(
            onInvoke: (_) => _handleOpenFile(context),
          ),
        },
        child: Focus(autofocus: true, child: child),
      ),
    );
  }

  void _handleNewTab(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    tabProvider.createTab();
  }

  void _handleCloseTab(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    final activeTab = tabProvider.activeTab;
    if (activeTab != null) {
      tabProvider.closeTab(activeTab.id);
    }
  }

  void _handleNextTab(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    final tabs = tabProvider.tabs;
    final activeTab = tabProvider.activeTab;

    if (tabs.length > 1 && activeTab != null) {
      final currentIndex = tabs.indexWhere((tab) => tab.id == activeTab.id);
      final nextIndex = (currentIndex + 1) % tabs.length;
      tabProvider.switchToTab(tabs[nextIndex].id);
    }
  }

  void _handlePreviousTab(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    final tabs = tabProvider.tabs;
    final activeTab = tabProvider.activeTab;

    if (tabs.length > 1 && activeTab != null) {
      final currentIndex = tabs.indexWhere((tab) => tab.id == activeTab.id);
      final previousIndex = (currentIndex - 1 + tabs.length) % tabs.length;
      tabProvider.switchToTab(tabs[previousIndex].id);
    }
  }

  void _handleSaveFile(BuildContext context) async {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    final success = await tabProvider.saveCurrentTab();

    if (success) {
      // Show success feedback
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('File saved successfully')));
    } else {
      // Show error feedback
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save file')));
    }
  }

  void _handleOpenFile(BuildContext context) async {
    final tabProvider = Provider.of<TabProvider>(context, listen: false);
    final success = await tabProvider.openFile();

    if (success) {
      // Show success feedback
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('File opened successfully')));
    } else {
      // Show error feedback
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to open file')));
    }
  }
}

// Intent classes for keyboard shortcuts
class _NewTabIntent extends Intent {
  const _NewTabIntent();
}

class _CloseTabIntent extends Intent {
  const _CloseTabIntent();
}

class _NextTabIntent extends Intent {
  const _NextTabIntent();
}

class _PreviousTabIntent extends Intent {
  const _PreviousTabIntent();
}

class _SaveFileIntent extends Intent {
  const _SaveFileIntent();
}

class _OpenFileIntent extends Intent {
  const _OpenFileIntent();
}
