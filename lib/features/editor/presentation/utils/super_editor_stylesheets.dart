import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

class SuperEditorStylesheets {
  SuperEditorStylesheets._();
  static final SuperEditorStylesheets _instance = SuperEditorStylesheets._();
  factory SuperEditorStylesheets() => _instance;

  // Super Editor comes with a standard stylesheet. You
  // can copy that stylesheet and adjust for your light
  // mode stylesheet.
  final _lightStylesheet = defaultStylesheet.copyWith();

  Stylesheet get lightStylesheet => _lightStylesheet;
  Stylesheet get darkStylesheet => _darkStylesheet;

  // For dark mode, you can define an entirely new stylesheet,
  // or you can copy and adjust your light mode stylesheet.
  //
  // Note the background color of your editor is controlled
  // by your widget tree outside of SuperEditor, which is
  // why this stylesheet doesn't include a background color.
  Stylesheet get _darkStylesheet => _lightStylesheet.copyWith(
    addRulesAfter: [
      // Make all text a very light gray.
      StyleRule(BlockSelector.all, (doc, docNode) {
        return {"textStyle": const TextStyle(color: Color(0xFFCCCCCC))};
      }),
      // Make the headers a medium gray.
      StyleRule(const BlockSelector("header1"), (doc, docNode) {
        return {"textStyle": const TextStyle(color: Color(0xFF888888))};
      }),
      StyleRule(const BlockSelector("header2"), (doc, docNode) {
        return {"textStyle": const TextStyle(color: Color(0xFF888888))};
      }),
    ],
  );
}
