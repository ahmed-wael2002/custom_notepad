/// Represents a file with its metadata
class FileEntity {
  final String path;
  final String name;
  final String extension;
  final int size;
  final DateTime lastModified;
  final bool exists;

  const FileEntity({
    required this.path,
    required this.name,
    required this.extension,
    required this.size,
    required this.lastModified,
    this.exists = true,
  });

  FileEntity copyWith({
    String? path,
    String? name,
    String? extension,
    int? size,
    DateTime? lastModified,
    bool? exists,
  }) {
    return FileEntity(
      path: path ?? this.path,
      name: name ?? this.name,
      extension: extension ?? this.extension,
      size: size ?? this.size,
      lastModified: lastModified ?? this.lastModified,
      exists: exists ?? this.exists,
    );
  }

  /// Get the full file name with extension
  String get fullName => '$name$extension';

  /// Check if the file is a text file
  bool get isTextFile {
    const textExtensions = [
      '.txt',
      '.md',
      '.json',
      '.xml',
      '.html',
      '.css',
      '.js',
      '.dart',
      '.py',
      '.java',
      '.cpp',
      '.c',
      '.h',
      '.cs',
      '.php',
      '.rb',
      '.go',
      '.rs',
      '.swift',
      '.kt',
      '.scala',
      '.sh',
      '.bat',
      '.yml',
      '.yaml',
      '.toml',
      '.ini',
      '.cfg',
      '.conf',
      '.log',
    ];
    return textExtensions.contains(extension.toLowerCase());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FileEntity && other.path == path;
  }

  @override
  int get hashCode => path.hashCode;

  @override
  String toString() =>
      'FileEntity(path: $path, name: $name, extension: $extension)';
}
