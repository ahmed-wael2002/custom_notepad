import '../entities/tab_entity.dart';
import '../repositories/tab_repository.dart';
import 'package:super_editor/super_editor.dart';

/// Use case for creating a new tab
class CreateTabUseCase {
  final TabRepository _repository;

  CreateTabUseCase(this._repository);

  /// Creates a new tab with a default editor
  TabEntity execute({String? customTitle}) {
    final id = _repository.getNextTabId();
    final now = DateTime.now();
    final title =
        customTitle ?? 'Untitled ${_repository.getAllTabs().length + 1}';

    final editor = createDefaultDocumentEditor(
      document: MutableDocument.empty(),
      composer: MutableDocumentComposer(),
    );

    final tab = TabEntity(
      id: id,
      title: title,
      editor: editor,
      isModified: false,
      createdAt: now,
      lastModified: now,
    );

    _repository.addTab(tab);
    _repository.setActiveTab(id);

    return tab;
  }
}
