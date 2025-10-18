import '../entities/tab_entity.dart';

/// Abstract repository for managing tabs
abstract class TabRepository {
  /// Get all tabs
  List<TabEntity> getAllTabs();

  /// Get tab by ID
  TabEntity? getTabById(String id);

  /// Add a new tab
  void addTab(TabEntity tab);

  /// Remove a tab
  void removeTab(String id);

  /// Update a tab
  void updateTab(TabEntity tab);

  /// Get the currently active tab
  TabEntity? getActiveTab();

  /// Set the active tab
  void setActiveTab(String id);

  /// Get the next available tab ID
  String getNextTabId();
}
