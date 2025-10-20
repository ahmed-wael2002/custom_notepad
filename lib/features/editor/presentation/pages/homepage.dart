import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:iconsax/iconsax.dart';
import '../providers/tab_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isVerySmallScreen = screenSize.width < 400;
    final isLandscape = screenSize.width > screenSize.height;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20.0 : 32.0,
            vertical: isSmallScreen ? 20.0 : 32.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isSmallScreen ? double.infinity : 600,
                maxHeight: isLandscape
                    ? screenSize.height * 0.8
                    : screenSize.height * 0.9,
              ),
              child: SingleChildScrollView(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              children: [
                                // Animation with modern styling
                                Container(
                                  height: isVerySmallScreen
                                      ? 180
                                      : isSmallScreen
                                      ? 220
                                      : 260,
                                  width: isVerySmallScreen
                                      ? 180
                                      : isSmallScreen
                                      ? 220
                                      : 260,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Lottie.asset("assets/animation.json"),
                                ),

                                const SizedBox(height: 32),

                                // Modern title with gradient text
                                ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: isDark
                                        ? [Colors.white, Colors.grey[300]!]
                                        : [
                                            const Color(0xFF667eea),
                                            const Color(0xFF764ba2),
                                          ],
                                  ).createShader(bounds),
                                  child: Text(
                                    "Let's create something amazing! ✨",
                                    style: TextStyle(
                                      fontSize: isVerySmallScreen
                                          ? 22
                                          : isSmallScreen
                                          ? 26
                                          : 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Subtitle
                                Text(
                                  "Your creative space awaits",
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: isDark
                                        ? Colors.grey[300]
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 40),

                                // Modern button layout
                                if (isSmallScreen && !isLandscape) ...[
                                  // Stack buttons vertically on small screens in portrait
                                  Column(
                                    children: [
                                      _buildModernButton(
                                        context: context,
                                        onPressed: () {
                                          Provider.of<TabProvider>(
                                            context,
                                            listen: false,
                                          ).createTab();
                                        },
                                        icon: Iconsax.document,
                                        label: 'New Note',
                                        isPrimary: true,
                                        isDark: isDark,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildModernButton(
                                        context: context,
                                        onPressed: () async {
                                          final success =
                                              await Provider.of<TabProvider>(
                                                context,
                                                listen: false,
                                              ).openFile();
                                          if (!success && context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'Failed to open file',
                                                ),
                                                backgroundColor:
                                                    Colors.red[400],
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        icon: Iconsax.folder_open,
                                        label: 'Open File',
                                        isPrimary: false,
                                        isDark: isDark,
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  // Row layout for larger screens or landscape
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 20,
                                    runSpacing: 16,
                                    children: [
                                      _buildModernButton(
                                        context: context,
                                        onPressed: () {
                                          Provider.of<TabProvider>(
                                            context,
                                            listen: false,
                                          ).createTab();
                                        },
                                        icon: Iconsax.document,
                                        label: 'New Note',
                                        isPrimary: true,
                                        isDark: isDark,
                                      ),
                                      _buildModernButton(
                                        context: context,
                                        onPressed: () async {
                                          final success =
                                              await Provider.of<TabProvider>(
                                                context,
                                                listen: false,
                                              ).openFile();
                                          if (!success && context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'Failed to open file',
                                                ),
                                                backgroundColor:
                                                    Colors.red[400],
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        icon: Iconsax.folder_open,
                                        label: 'Open File',
                                        isPrimary: false,
                                        isDark: isDark,
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool isPrimary,
    required bool isDark,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return SizedBox(
      width: isSmallScreen ? double.infinity : null,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: isPrimary ? 8 : 2,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          splashColor: isPrimary
              ? Colors.white.withValues(alpha: 0.2)
              : isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.1),
          highlightColor: isPrimary
              ? Colors.white.withValues(alpha: 0.1)
              : isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 24 : 32,
              vertical: isSmallScreen ? 16 : 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: isPrimary
                  ? LinearGradient(
                      colors: isDark
                          ? [Colors.teal[400]!, Colors.teal[600]!]
                          : [Colors.teal[500]!, Colors.teal[700]!],
                    )
                  : null,
              color: isPrimary
                  ? null
                  : isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey[100],
              border: isPrimary
                  ? null
                  : Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.grey[300]!,
                      width: 1.5,
                    ),
              boxShadow: isPrimary
                  ? [
                      BoxShadow(
                        color: Colors.teal.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: 0,
                  child: Icon(
                    icon,
                    color: isPrimary
                        ? Colors.white
                        : isDark
                        ? Colors.white
                        : Colors.grey[700],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isPrimary
                        ? Colors.white
                        : isDark
                        ? Colors.white
                        : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 14 : 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
