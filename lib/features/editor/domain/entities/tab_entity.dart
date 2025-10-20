import 'package:super_editor/super_editor.dart';
import 'file_entity.dart';

/// Represents a single tab in the editor
class TabEntity {
  final String id;
  final String title;
  final Editor editor;
  final bool isModified;
  final DateTime createdAt;
  final DateTime lastModified;
  final FileEntity? file;

  const TabEntity({
    required this.id,
    required this.title,
    required this.editor,
    this.isModified = false,
    required this.createdAt,
    required this.lastModified,
    this.file,
  });

  TabEntity copyWith({
    String? id,
    String? title,
    Editor? editor,
    bool? isModified,
    DateTime? createdAt,
    DateTime? lastModified,
    FileEntity? file,
  }) {
    return TabEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      editor: editor ?? this.editor,
      isModified: isModified ?? this.isModified,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
      file: file ?? this.file,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
