import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tab_provider.dart';
import '../../domain/entities/tab_entity.dart';

/// Custom tab bar widget for the editor
class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, tabProvider, child) {
        final tabs = tabProvider.tabs;
        final activeTab = tabProvider.activeTab;

        if (tabs.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      final tab = tabs[index];
                      final isActive = activeTab?.id == tab.id;

                      return _TabItem(
                        tab: tab,
                        isActive: isActive,
                        onTap: () => tabProvider.switchToTab(tab.id),
                        onClose: () => tabProvider.closeTab(tab.id),
                      );
                    },
                  ),
                ),
              ),
              // Add new tab button
              IconButton(
                onPressed: () => tabProvider.createTab(),
                icon: const Icon(Icons.add, size: 20),
                tooltip: 'New Tab (Ctrl+T)',
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Individual tab item widget
class _TabItem extends StatelessWidget {
  final TabEntity tab;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const _TabItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 120, maxWidth: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isActive ? colorScheme.primary : colorScheme.surface,
        ),
        child: Row(
          children: [
            // Tab title
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  '${tab.title}${tab.isModified ? ' *' : ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: isActive
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Close button
            Consumer<TabProvider>(
              builder: (context, tabProvider, child) {
                return tab.id != 'tab_1' || tabProvider.tabs.length > 1
                    ? IconButton(
                        onPressed: onClose,
                        icon: const Icon(Icons.close, size: 16),
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                        padding: EdgeInsets.zero,
                        tooltip: 'Close tab',
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
