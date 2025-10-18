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
            height: 1.5,
          ),
        };
      }),

      // Headers with GitHub styling
      StyleRule(const BlockSelector("header1"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF1F2328),
            fontSize: 32,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          "padding": const EdgeInsets.only(bottom: 8, top: 24),
        };
      }),
      StyleRule(const BlockSelector("header2"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF1F2328),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          "padding": const EdgeInsets.only(bottom: 8, top: 16),
        };
      }),
      StyleRule(const BlockSelector("header3"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF1F2328),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          "padding": const EdgeInsets.only(bottom: 8, top: 16),
        };
      }),

      // Inline code - GitHub style
      StyleRule(const BlockSelector("code"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF0969DA), // GitHub's code color
            fontFamily: 'monospace',
            fontSize: 85, // 85% of parent font size
          ),
          "backgroundColor": const Color(
            0xFFF6F8FA,
          ), // GitHub's code background
          "padding": const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          "decoration": BoxDecoration(
            color: const Color(0xFFF6F8FA),
            borderRadius: BorderRadius.circular(6),
          ),
        };
      }),

      // Code blocks - GitHub style
      StyleRule(const BlockSelector("codeblock"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontFamily: 'monospace',
            fontSize: 14,
            height: 1.45,
          ),
          "backgroundColor": const Color(0xFFF6F8FA),
          "padding": const EdgeInsets.all(16),
          "decoration": BoxDecoration(
            color: const Color(0xFFF6F8FA),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFD0D7DE), width: 1),
          ),
        };
      }),

      // Blockquotes - GitHub style
      StyleRule(const BlockSelector("blockquote"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF656D76),
            fontSize: 16,
            height: 1.5,
          ),
          "padding": const EdgeInsets.only(left: 16, top: 0, bottom: 0),
          "decoration": const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFFD0D7DE), width: 4),
            ),
          ),
        };
      }),

      // Links - GitHub blue
      StyleRule(const BlockSelector("link"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF0969DA),
            decoration: TextDecoration.underline,
          ),
        };
      }),

      // Lists
      StyleRule(const BlockSelector("listItem"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF24292F),
            fontSize: 16,
            height: 1.5,
          ),
        };
      }),
    ],
  );

  // Dark theme - GitHub dark mode colors
  Stylesheet get _darkStylesheet => _lightStylesheet.copyWith(
    addRulesAfter: [
      // Base text styling - GitHub dark theme
      StyleRule(BlockSelector.all, (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC), // GitHub's dark text color
            fontSize: 16,
            height: 1.5,
          ),
        };
      }),

      // Headers with GitHub dark styling
      StyleRule(const BlockSelector("header1"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 32,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          "padding": const EdgeInsets.only(bottom: 8, top: 24),
        };
      }),
      StyleRule(const BlockSelector("header2"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          "padding": const EdgeInsets.only(bottom: 8, top: 16),
        };
      }),
      StyleRule(const BlockSelector("header3"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          "padding": const EdgeInsets.only(bottom: 8, top: 16),
        };
      }),

      // Inline code - GitHub dark style
      StyleRule(const BlockSelector("code"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF7DD3FC), // GitHub's dark code color
            fontFamily: 'monospace',
            fontSize: 85, // 85% of parent font size
          ),
          "backgroundColor": const Color(
            0xFF161B22,
          ), // GitHub's dark code background
          "padding": const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          "decoration": BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(6),
          ),
        };
      }),

      // Code blocks - GitHub dark style
      StyleRule(const BlockSelector("codeblock"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontFamily: 'monospace',
            fontSize: 14,
            height: 1.45,
          ),
          "backgroundColor": const Color(0xFF0D1117),
          "padding": const EdgeInsets.all(16),
          "decoration": BoxDecoration(
            color: const Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF30363D), width: 1),
          ),
        };
      }),

      // Blockquotes - GitHub dark style
      StyleRule(const BlockSelector("blockquote"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFF8B949E),
            fontSize: 16,
            height: 1.5,
          ),
          "padding": const EdgeInsets.only(left: 16, top: 0, bottom: 0),
          "decoration": const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFF30363D), width: 4),
            ),
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

      // Lists
      StyleRule(const BlockSelector("listItem"), (doc, docNode) {
        return {
          "textStyle": const TextStyle(
            color: Color(0xFFF0F6FC),
            fontSize: 16,
            height: 1.5,
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
}
