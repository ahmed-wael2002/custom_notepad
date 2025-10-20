import 'package:flutter/material.dart';
import 'package:notepad/features/editor/presentation/utils/super_editor_stylesheets.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_markdown/super_editor_markdown.dart';

class EditorWidget extends StatefulWidget {
  final bool isDarkMode;
  const EditorWidget({super.key, this.isDarkMode = false});

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  late final Editor _editor;

  @override
  void initState() {
    super.initState();
    _editor = createDefaultDocumentEditor(
      document: MutableDocument.empty(),
      composer: MutableDocumentComposer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (SuperEditor(
      editor: _editor,
      stylesheet: widget.isDarkMode
          ? SuperEditorStylesheets().darkStylesheet
          : SuperEditorStylesheets().lightStylesheet,
      shrinkWrap: true,
      selectionStyle: SelectionStyles(
        highlightEmptyTextBlocks: false,
        selectionColor: Theme.of(context).colorScheme.primary,
      ),
      plugins: {MarkdownInlineUpstreamSyntaxPlugin()},
    ));
  }

  @override
  void dispose() {
    _editor.dispose();
    super.dispose();
  }
}
