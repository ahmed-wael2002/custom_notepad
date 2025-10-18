import '../../domain/entities/tab_entity.dart';
import '../../domain/repositories/tab_repository.dart';

/// Implementation of TabRepository
class TabRepositoryImpl implements TabRepository {
  final List<TabEntity> _tabs = [];
  String? _activeTabId;
  int _nextIdCounter = 1;

  @override
  List<TabEntity> getAllTabs() => List.unmodifiable(_tabs);

  @override
  TabEntity? getTabById(String id) {
    try {
      return _tabs.firstWhere((tab) => tab.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  void addTab(TabEntity tab) {
    _tabs.add(tab);
  }

  @override
  void removeTab(String id) {
    _tabs.removeWhere((tab) => tab.id == id);
    if (_activeTabId == id) {
      _activeTabId = _tabs.isNotEmpty ? _tabs.last.id : null;
    }
  }

  @override
  void updateTab(TabEntity tab) {
    final index = _tabs.indexWhere((t) => t.id == tab.id);
    if (index != -1) {
      _tabs[index] = tab;
    }
  }

  @override
  TabEntity? getActiveTab() {
    if (_activeTabId == null) return null;
    return getTabById(_activeTabId!);
  }

  @override
  void setActiveTab(String id) {
    if (getTabById(id) != null) {
      _activeTabId = id;
    }
  }

  @override
  String getNextTabId() {
    return 'tab_${_nextIdCounter++}';
  }
}
