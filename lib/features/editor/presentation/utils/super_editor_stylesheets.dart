import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

class SuperEditorStylesheets {
  SuperEditorStylesheets._();
  static final SuperEditorStylesheets _instance = SuperEditorStylesheets._();
  factory SuperEditorStylesheets() => _instance;

  // GitHub Markdown CSS inspired stylesheets
  // Light theme based on GitHub's default styling
  Stylesheet get lightStylesheet => _lightStylesheet;
  Stylesheet get darkStylesheet => _darkStylesheet;

  // Light theme - GitHub default colors
  Stylesheet get _lightStylesheet => defaultStylesheet.copyWith(
    addRulesAfter: [
      // Base text styling
      StyleRule(BlockSelector.all, (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F), // GitHub's text color
            fontSize: 16,
            // height: 1.5,
          ),
        };
      }),

      // Links - GitHub dark blue
      StyleRule(const BlockSelector("link"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF58A6FF),
            decoration: TextDecoration.underline,
          ),
        };
      }),

      // Inline code (e.g., `code`)
      StyleRule(const BlockSelector("code"), (doc, docNode) {
        return {
          "textStyle": TextStyle(
            color: const Color(0xFFD73A49), // GitHub red
            backgroundColor: const Color(0xFFD73A49).withOpacity(0.12),
            fontFamily: 'monospace',
          ),
        };
      }),

      // Headings - larger sizes (light)
      StyleRule(const BlockSelector("header1"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header2"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header3"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header4"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header5"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header6"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        };
      }),

      // Lists
      StyleRule(const BlockSelector("listItem"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 16,
            // height: 1.5,
          ),
        };
      }),

      // Bold text
      StyleRule(const BlockSelector("bold"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontWeight: FontWeight.bold,
          ),
        };
      }),

      // Italic text
      StyleRule(const BlockSelector("italic"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontStyle: FontStyle.italic,
          ),
        };
      }),
    ],
  );

  // Dark theme - GitHub dark colors
  Stylesheet get _darkStylesheet => defaultStylesheet.copyWith(
    addRulesAfter: [
      // Base text styling
      StyleRule(BlockSelector.all, (doc, docNode) {
        return {
          "textStyle": const TextStyle(color: Color(0xFFF0F6FC), fontSize: 16),
        };
      }),

      // Links - GitHub dark blue
      StyleRule(const BlockSelector("link"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF58A6FF),
            decoration: TextDecoration.underline,
          ),
        };
      }),

      // Inline code (e.g., `code`)
      StyleRule(const BlockSelector("code"), (doc, docNode) {
        return {
          "textStyle": TextStyle(
            color: Colors.teal, // Softer red on dark
            backgroundColor: Colors.teal.withOpacity(0.18),
            fontFamily: 'monospace',
          ),
        };
      }),

      // Headings - larger sizes (dark)
      StyleRule(const BlockSelector("header1"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header2"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header3"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header4"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header5"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        };
      }),
      StyleRule(const BlockSelector("header6"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        };
      }),

      // Lists
      StyleRule(const BlockSelector("listItem"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(color: Color(0xFFF0F6FC), fontSize: 16),
        };
      }),

      // Bold text
      StyleRule(const BlockSelector("bold"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontWeight: FontWeight.bold,
          ),
        };
      }),

      // Italic text
      StyleRule(const BlockSelector("italic"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontStyle: FontStyle.italic,
          ),
        };
      }),
    ],
  );
}
