import '../entities/tab_entity.dart';
import '../repositories/tab_repository.dart';

/// Use case for switching between tabs
class SwitchTabUseCase {
  final TabRepository _repository;

  SwitchTabUseCase(this._repository);

  /// Switches to the specified tab
  TabEntity? execute(String tabId) {
    final tab = _repository.getTabById(tabId);
    if (tab != null) {
      _repository.setActiveTab(tabId);
    }
    return tab;
  }
}
