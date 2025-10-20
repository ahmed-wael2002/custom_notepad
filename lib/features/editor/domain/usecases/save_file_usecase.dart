import '../entities/file_entity.dart';
import '../repositories/file_repository.dart';
import '../services/file_dialog_service.dart';
import 'package:super_editor/super_editor.dart';

/// Use case for saving a file
class SaveFileUseCase {
  final FileRepository _fileRepository;
  final FileDialogService _fileDialogService;

  SaveFileUseCase(this._fileRepository, this._fileDialogService);

  /// Save content to a file, showing file picker if no path provided
  Future<FileEntity?> execute({
    required String content,
    String? filePath,
    String? fileName,
    String? fileExtension,
  }) async {
    try {
      String targetPath = filePath ?? '';

      // If no file path provided, show save dialog
      if (targetPath.isEmpty) {
        final selectedPath = await _fileDialogService.showSaveDialog(
          fileName: fileName,
          fileExtension: fileExtension,
        );

        if (selectedPath == null) {
          return null; // User cancelled
        }

        targetPath = selectedPath;
      }

      // Save the file
      final savedFile = await _fileRepository.saveFile(content, targetPath);
      return savedFile;
    } catch (e) {
      throw SaveFileException('Failed to save file: $e');
    }
  }

  /// Save content from an editor to a file
  Future<FileEntity?> saveFromEditor({
    required Editor editor,
    String? filePath,
    String? fileName,
    String? fileExtension,
  }) async {
    try {
      // Convert editor content to string
      final content = _extractContentFromEditor(editor);
      return await execute(
        content: content,
        filePath: filePath,
        fileName: fileName,
        fileExtension: fileExtension,
      );
    } catch (e) {
      throw SaveFileException('Failed to save from editor: $e');
    }
  }

  /// Extract text content from SuperEditor with markdown formatting
  String _extractContentFromEditor(Editor editor) {
    final document = editor.document;
    final buffer = StringBuffer();

    // Iterate through all nodes in the document
    for (int i = 0; i < document.nodeCount; i++) {
      final node = document.getNodeAt(i);
      if (node == null) continue;

      // Extract text content from the node
      final text = _extractTextFromNode(node);
      buffer.write(text);

      // Add newline after each node except the last one
      if (i < document.nodeCount - 1) {
        buffer.write('\n');
      }
    }

    return buffer.toString();
  }

  /// Extract text content from any node type
  String _extractTextFromNode(DocumentNode node) {
    // Try to extract text content from the node
    if (node is TextNode) {
      return node.text.text;
    } else if (node is ParagraphNode) {
      return node.text.text;
    }

    // For other node types, return empty string
    return '';
  }
}

/// Custom exception for save file operations
class SaveFileException implements Exception {
  final String message;

  const SaveFileException(this.message);

  @override
  String toString() => 'SaveFileException: $message';
}
