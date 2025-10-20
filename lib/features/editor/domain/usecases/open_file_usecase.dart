import '../entities/file_entity.dart';
import '../repositories/file_repository.dart';
import '../services/file_dialog_service.dart';
import 'package:super_editor/super_editor.dart';

/// Use case for opening a file
class OpenFileUseCase {
  final FileRepository _fileRepository;
  final FileDialogService _fileDialogService;

  OpenFileUseCase(this._fileRepository, this._fileDialogService);

  /// Open a file, showing file picker if no path provided
  Future<OpenFileResult?> execute({String? filePath}) async {
    try {
      String targetPath = filePath ?? '';

      // If no file path provided, show open dialog
      if (targetPath.isEmpty) {
        final selectedPath = await _fileDialogService.showOpenDialog();

        if (selectedPath == null) {
          return null; // User cancelled
        }

        targetPath = selectedPath;
      }

      // Load the file content
      final content = await _fileRepository.loadFile(targetPath);
      final fileInfo = await _fileRepository.getFileInfo(targetPath);

      // Create editor with the loaded content
      final editor = _createEditorFromContent(content);

      return OpenFileResult(file: fileInfo, content: content, editor: editor);
    } catch (e) {
      throw OpenFileException('Failed to open file: $e');
    }
  }

  /// Create a SuperEditor from text content
  Editor _createEditorFromContent(String content) {
    final document = MutableDocument(nodes: _parseContentToNodes(content));

    return createDefaultDocumentEditor(
      document: document,
      composer: MutableDocumentComposer(),
    );
  }

  /// Parse text content into SuperEditor nodes
  List<DocumentNode> _parseContentToNodes(String content) {
    if (content.isEmpty) {
      return [ParagraphNode(id: '1', text: AttributedText())];
    }

    final lines = content.split('\n');
    final nodes = <DocumentNode>[];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final nodeId = '${i + 1}';

      if (line.trim().isEmpty) {
        // Empty line
        nodes.add(ParagraphNode(id: nodeId, text: AttributedText()));
      } else {
        // Text line
        nodes.add(ParagraphNode(id: nodeId, text: AttributedText(line)));
      }
    }

    // Ensure at least one node exists
    if (nodes.isEmpty) {
      nodes.add(ParagraphNode(id: '1', text: AttributedText()));
    }

    return nodes;
  }
}

/// Result of opening a file
class OpenFileResult {
  final FileEntity file;
  final String content;
  final Editor editor;

  const OpenFileResult({
    required this.file,
    required this.content,
    required this.editor,
  });
}

/// Custom exception for open file operations
class OpenFileException implements Exception {
  final String message;

  const OpenFileException(this.message);

  @override
  String toString() => 'OpenFileException: $message';
}
