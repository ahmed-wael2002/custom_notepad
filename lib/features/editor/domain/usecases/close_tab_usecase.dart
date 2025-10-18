import '../entities/tab_entity.dart';
import '../repositories/tab_repository.dart';

/// Use case for closing a tab
class CloseTabUseCase {
  final TabRepository _repository;

  CloseTabUseCase(this._repository);

  /// Closes a tab and returns the new active tab
  TabEntity? execute(String tabId) {
    final tabs = _repository.getAllTabs();
    final currentIndex = tabs.indexWhere((tab) => tab.id == tabId);

    if (currentIndex == -1) return null;

    // Dispose the editor before removing
    tabs[currentIndex].editor.dispose();
    _repository.removeTab(tabId);

    // Set new active tab
    final remainingTabs = _repository.getAllTabs();
    if (remainingTabs.isNotEmpty) {
      // If we closed the last tab, select the previous one
      // If we closed a middle tab, select the next one
      final newActiveIndex = currentIndex >= remainingTabs.length
          ? remainingTabs.length - 1
          : currentIndex;
      _repository.setActiveTab(remainingTabs[newActiveIndex].id);
      return remainingTabs[newActiveIndex];
    }

    return null;
  }
}
