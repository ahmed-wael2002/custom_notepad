import 'dart:io';
import '../../domain/entities/file_entity.dart';
import '../../domain/repositories/file_repository.dart';

/// Implementation of FileRepository using dart:io
class FileRepositoryImpl implements FileRepository {
  @override
  Future<FileEntity> saveFile(String content, String filePath) async {
    try {
      final file = File(filePath);
      await file.writeAsString(content);

      final stat = await file.stat();
      return FileEntity(
        path: filePath,
        name: _extractFileName(filePath),
        extension: _extractFileExtension(filePath),
        size: stat.size,
        lastModified: stat.modified,
        exists: true,
      );
    } catch (e) {
      throw FileOperationException('Failed to save file: $e');
    }
  }

  @override
  Future<String> loadFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw FileOperationException('File does not exist: $filePath');
      }

      return await file.readAsString();
    } catch (e) {
      throw FileOperationException('Failed to load file: $e');
    }
  }

  @override
  Future<FileEntity> getFileInfo(String filePath) async {
    try {
      final file = File(filePath);
      final exists = await file.exists();

      if (!exists) {
        return FileEntity(
          path: filePath,
          name: _extractFileName(filePath),
          extension: _extractFileExtension(filePath),
          size: 0,
          lastModified: DateTime.now(),
          exists: false,
        );
      }

      final stat = await file.stat();
      return FileEntity(
        path: filePath,
        name: _extractFileName(filePath),
        extension: _extractFileExtension(filePath),
        size: stat.size,
        lastModified: stat.modified,
        exists: true,
      );
    } catch (e) {
      throw FileOperationException('Failed to get file info: $e');
    }
  }

  @override
  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<FileEntity> createFile(String content, String filePath) async {
    try {
      final file = File(filePath);
      await file.writeAsString(content);

      final stat = await file.stat();
      return FileEntity(
        path: filePath,
        name: _extractFileName(filePath),
        extension: _extractFileExtension(filePath),
        size: stat.size,
        lastModified: stat.modified,
        exists: true,
      );
    } catch (e) {
      throw FileOperationException('Failed to create file: $e');
    }
  }

  @override
  Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      throw FileOperationException('Failed to delete file: $e');
    }
  }

  /// Extract file name from path
  String _extractFileName(String filePath) {
    final pathSegments = filePath.split(Platform.pathSeparator);
    final fileName = pathSegments.last;
    final lastDotIndex = fileName.lastIndexOf('.');

    if (lastDotIndex == -1) {
      return fileName;
    }

    return fileName.substring(0, lastDotIndex);
  }

  /// Extract file extension from path
  String _extractFileExtension(String filePath) {
    final pathSegments = filePath.split(Platform.pathSeparator);
    final fileName = pathSegments.last;
    final lastDotIndex = fileName.lastIndexOf('.');

    if (lastDotIndex == -1) {
      return '';
    }

    return fileName.substring(lastDotIndex);
  }
}

/// Custom exception for file operations
class FileOperationException implements Exception {
  final String message;

  const FileOperationException(this.message);

  @override
  String toString() => 'FileOperationException: $message';
}
