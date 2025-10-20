import 'package:flutter/material.dart';
import '../../domain/entities/tab_entity.dart';
import '../../domain/repositories/tab_repository.dart';
import '../../domain/repositories/file_repository.dart';
import '../../domain/usecases/create_tab_usecase.dart';
import '../../domain/usecases/close_tab_usecase.dart';
import '../../domain/usecases/switch_tab_usecase.dart';
import '../../domain/usecases/save_file_usecase.dart';
import '../../domain/usecases/open_file_usecase.dart';
import '../../domain/services/file_dialog_service.dart';
import '../../data/repositories/tab_repository_impl.dart';
import '../../data/repositories/file_repository_impl.dart';
import '../../data/services/file_dialog_service_impl.dart';

/// Provider for managing tab state
class TabProvider extends ChangeNotifier {
  late final TabRepository _repository;
  late final FileRepository _fileRepository;
  late final FileDialogService _fileDialogService;
  late final CreateTabUseCase _createTabUseCase;
  late final CloseTabUseCase _closeTabUseCase;
  late final SwitchTabUseCase _switchTabUseCase;
  late final SaveFileUseCase _saveFileUseCase;
  late final OpenFileUseCase _openFileUseCase;

  TabProvider({
    TabRepository? repository,
    FileRepository? fileRepository,
    FileDialogService? fileDialogService,
  }) {
    _repository = repository ?? TabRepositoryImpl();
    _fileRepository = fileRepository ?? FileRepositoryImpl();
    _fileDialogService = fileDialogService ?? FileDialogServiceImpl();
    _createTabUseCase = CreateTabUseCase(_repository);
    _closeTabUseCase = CloseTabUseCase(_repository);
    _switchTabUseCase = SwitchTabUseCase(_repository);
    _saveFileUseCase = SaveFileUseCase(_fileRepository, _fileDialogService);
    _openFileUseCase = OpenFileUseCase(_fileRepository, _fileDialogService);
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

  /// Save the current tab to a file
  Future<bool> saveCurrentTab() async {
    final activeTab = _repository.getActiveTab();
    if (activeTab == null) return false;

    try {
      final savedFile = await _saveFileUseCase.saveFromEditor(
        editor: activeTab.editor,
        filePath: activeTab.file?.path,
        fileName: activeTab.file?.name,
        fileExtension: activeTab.file?.extension,
      );

      if (savedFile != null) {
        // Update tab with file information
        final updatedTab = activeTab.copyWith(
          file: savedFile,
          title: savedFile.name,
          isModified: false,
          lastModified: DateTime.now(),
        );
        _repository.updateTab(updatedTab);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      // Handle error - could show a snackbar or dialog
      print('Error saving file: $e');
      return false;
    }
  }

  /// Save the current tab to a new file
  Future<bool> saveCurrentTabAs() async {
    final activeTab = _repository.getActiveTab();
    if (activeTab == null) return false;

    try {
      final savedFile = await _saveFileUseCase.saveFromEditor(
        editor: activeTab.editor,
        fileExtension: '.md', // Default to markdown
      );

      if (savedFile != null) {
        // Update tab with file information
        final updatedTab = activeTab.copyWith(
          file: savedFile,
          title: savedFile.name,
          isModified: false,
          lastModified: DateTime.now(),
        );
        _repository.updateTab(updatedTab);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      // Handle error - could show a snackbar or dialog
      print('Error saving file: $e');
      return false;
    }
  }

  /// Open a file in a new tab
  Future<bool> openFile() async {
    try {
      final openResult = await _openFileUseCase.execute();

      if (openResult != null) {
        // Create a new tab with the opened file
        final id = _repository.getNextTabId();
        final now = DateTime.now();

        final newTab = TabEntity(
          id: id,
          title: openResult.file.name,
          editor: openResult.editor,
          isModified: false,
          createdAt: now,
          lastModified: now,
          file: openResult.file,
        );

        _repository.addTab(newTab);
        _repository.setActiveTab(id);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      // Handle error - could show a snackbar or dialog
      print('Error opening file: $e');
      return false;
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
