import '../entities/file_entity.dart';

/// Abstract repository for file operations
abstract class FileRepository {
  /// Save content to a file
  Future<FileEntity> saveFile(String content, String filePath);

  /// Load content from a file
  Future<String> loadFile(String filePath);

  /// Get file metadata
  Future<FileEntity> getFileInfo(String filePath);

  /// Check if file exists
  Future<bool> fileExists(String filePath);

  /// Create a new file with content
  Future<FileEntity> createFile(String content, String filePath);

  /// Delete a file
  Future<bool> deleteFile(String filePath);
}
