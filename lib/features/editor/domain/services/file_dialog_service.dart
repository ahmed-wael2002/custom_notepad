/// Abstract service for file dialog operations
abstract class FileDialogService {
  /// Show save file dialog
  Future<String?> showSaveDialog({String? fileName, String? fileExtension});

  /// Show open file dialog
  Future<String?> showOpenDialog();
}
