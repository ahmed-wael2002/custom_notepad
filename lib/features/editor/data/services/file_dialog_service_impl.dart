import 'package:file_picker/file_picker.dart';
import '../../domain/services/file_dialog_service.dart';

/// Implementation of FileDialogService using file_picker package
class FileDialogServiceImpl implements FileDialogService {
  @override
  Future<String?> showSaveDialog({
    String? fileName,
    String? fileExtension,
  }) async {
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save File',
        fileName: fileName ?? 'untitled',
        type: FileType.custom,
        allowedExtensions: _getAllowedExtensions(fileExtension ?? '.md'),
      );

      return result;
    } catch (e) {
      throw FileDialogException('Failed to show save dialog: $e');
    }
  }

  @override
  Future<String?> showOpenDialog() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Open File',
        type: FileType.custom,
        allowedExtensions: _getDefaultAllowedExtensions(),
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.first.path;
      }

      return null;
    } catch (e) {
      throw FileDialogException('Failed to show open dialog: $e');
    }
  }

  /// Get allowed extensions based on file extension parameter
  List<String> _getAllowedExtensions(String? fileExtension) {
    if (fileExtension != null && fileExtension.isNotEmpty) {
      // Remove the dot if present
      final ext = fileExtension.startsWith('.')
          ? fileExtension.substring(1)
          : fileExtension;
      return [ext];
    }

    return _getDefaultAllowedExtensions();
  }

  /// Get default allowed extensions for text files
  List<String> _getDefaultAllowedExtensions() {
    return [
      'md', // Markdown files first
      'txt',
      'json',
      'xml',
      'html',
      'css',
      'js',
      'dart',
      'py',
      'java',
      'cpp',
      'c',
      'h',
      'cs',
      'php',
      'rb',
      'go',
      'rs',
      'swift',
      'kt',
      'scala',
      'sh',
      'bat',
      'yml',
      'yaml',
      'toml',
      'ini',
      'cfg',
      'conf',
      'log',
    ];
  }
}

/// Custom exception for file dialog operations
class FileDialogException implements Exception {
  final String message;

  const FileDialogException(this.message);

  @override
  String toString() => 'FileDialogException: $message';
}
