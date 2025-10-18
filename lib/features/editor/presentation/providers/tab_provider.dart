import 'package:flutter/material.dart';
import '../../domain/entities/tab_entity.dart';
import '../../domain/repositories/tab_repository.dart';
import '../../domain/usecases/create_tab_usecase.dart';
import '../../domain/usecases/close_tab_usecase.dart';
import '../../domain/usecases/switch_tab_usecase.dart';
import '../../data/repositories/tab_repository_impl.dart';

/// Provider for managing tab state
class TabProvider extends ChangeNotifier {
  late final TabRepository _repository;
  late final CreateTabUseCase _createTabUseCase;
  late final CloseTabUseCase _closeTabUseCase;
  late final SwitchTabUseCase _switchTabUseCase;

  TabProvider({TabRepository? repository}) {
    _repository = repository ?? TabRepositoryImpl();
    _createTabUseCase = CreateTabUseCase(_repository);
    _closeTabUseCase = CloseTabUseCase(_repository);
    _switchTabUseCase = SwitchTabUseCase(_repository);
  }

  /// Get all tabs
  List<TabEntity> get tabs => _repository.getAllTabs();

  /// Get active tab
  TabEntity? get activeTab => _repository.getActiveTab();

  /// Create a new tab
  void createTab({String? customTitle}) {
    _createTabUseCase.execute(customTitle: customTitle);
    notifyListeners();
  }

  /// Close a tab
  void closeTab(String tabId) {
    _closeTabUseCase.execute(tabId);
    notifyListeners();
  }

  /// Switch to a tab
  void switchToTab(String tabId) {
    _switchTabUseCase.execute(tabId);
    notifyListeners();
  }

  /// Update tab title
  void updateTabTitle(String tabId, String title) {
    final tab = _repository.getTabById(tabId);
    if (tab != null) {
      final updatedTab = tab.copyWith(
        title: title,
        lastModified: DateTime.now(),
      );
      _repository.updateTab(updatedTab);
      notifyListeners();
    }
  }

  /// Mark tab as modified
  void markTabAsModified(String tabId, bool isModified) {
    final tab = _repository.getTabById(tabId);
    if (tab != null) {
      final updatedTab = tab.copyWith(
        isModified: isModified,
        lastModified: DateTime.now(),
      );
      _repository.updateTab(updatedTab);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Dispose all editors
    for (final tab in _repository.getAllTabs()) {
      tab.editor.dispose();
    }
    super.dispose();
  }
}
