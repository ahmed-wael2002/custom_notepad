import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import '../providers/tab_provider.dart';
import '../../domain/entities/tab_entity.dart';

/// Custom tab bar widget for the editor
class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<TabProvider>(
      builder: (context, tabProvider, child) {
        final tabs = tabProvider.tabs;
        final activeTab = tabProvider.activeTab;

        if (tabs.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.7),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      final tab = tabs[index];
                      final isActive = activeTab?.id == tab.id;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _TabItem(
                          tab: tab,
                          isActive: isActive,
                          onTap: () => tabProvider.switchToTab(tab.id),
                          onClose: () => tabProvider.closeTab(tab.id),
                          isDark: isDark,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Add new tab button
              _ModernAddButton(
                onPressed: () => tabProvider.createTab(),
                isDark: isDark,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Individual tab item widget
class _TabItem extends StatefulWidget {
  final TabEntity tab;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onClose;
  final bool isDark;

  const _TabItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.onClose,
    required this.isDark,
  });

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: widget.onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                constraints: const BoxConstraints(minWidth: 140, maxWidth: 220),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: widget.isActive
                      ? LinearGradient(
                          colors: widget.isDark
                              ? [Colors.teal[400]!, Colors.teal[600]!]
                              : [Colors.teal[500]!, Colors.teal[700]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: widget.isActive
                      ? null
                      : widget.isDark
                      ? Colors.white.withValues(alpha: _isHovered ? 0.15 : 0.08)
                      : Colors.grey.withValues(alpha: _isHovered ? 0.2 : 0.1),
                  border: widget.isActive
                      ? null
                      : Border.all(
                          color: widget.isDark
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.grey.withValues(alpha: 0.3),
                          width: 1,
                        ),
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: Colors.teal.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : _isHovered
                      ? [
                          BoxShadow(
                            color: widget.isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.grey.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    // Tab title
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          '${widget.tab.title}${widget.tab.isModified ? ' •' : ''}',
                          style: TextStyle(
                            fontSize: 14,
                            color: widget.isActive
                                ? Colors.white
                                : widget.isDark
                                ? Colors.white
                                : Colors.grey[700],
                            fontWeight: widget.isActive
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Close button
                    Consumer<TabProvider>(
                      builder: (context, tabProvider, child) {
                        return widget.tab.id != 'tab_1' ||
                                tabProvider.tabs.length > 1
                            ? AnimatedOpacity(
                                opacity: _isHovered || widget.isActive
                                    ? 1.0
                                    : 0.0,
                                duration: const Duration(milliseconds: 200),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: widget.onClose,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      child: Icon(
                                        Iconsax.close_circle,
                                        size: 16,
                                        color: widget.isActive
                                            ? Colors.white.withValues(
                                                alpha: 0.8,
                                              )
                                            : widget.isDark
                                            ? Colors.white.withValues(
                                                alpha: 0.7,
                                              )
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Modern add button for creating new tabs
class _ModernAddButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isDark;

  const _ModernAddButton({required this.onPressed, required this.isDark});

  @override
  State<_ModernAddButton> createState() => _ModernAddButtonState();
}

class _ModernAddButtonState extends State<_ModernAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.isDark
                        ? Colors.white.withValues(
                            alpha: _isHovered ? 0.15 : 0.08,
                          )
                        : Colors.grey.withValues(alpha: _isHovered ? 0.2 : 0.1),
                    border: Border.all(
                      color: widget.isDark
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.grey.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: widget.isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Iconsax.add,
                    size: 20,
                    color: widget.isDark
                        ? Colors.white.withValues(alpha: 0.8)
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
