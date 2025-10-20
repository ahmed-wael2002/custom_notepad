import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../providers/tab_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isVerySmallScreen = screenSize.width < 400;
    final isLandscape = screenSize.width > screenSize.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16.0 : 32.0,
            vertical: isSmallScreen ? 16.0 : 32.0,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animation with responsive sizing
                    SizedBox(
                      height: isVerySmallScreen
                          ? 200
                          : isSmallScreen
                          ? 250
                          : 300,
                      width: isVerySmallScreen
                          ? 200
                          : isSmallScreen
                          ? 250
                          : 300,
                      child: Lottie.asset("assets/animation.json"),
                    ),

                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Title with responsive font size
                    Text(
                      "Let's jot things down!",
                      style: TextStyle(
                        fontSize: isVerySmallScreen
                            ? 20
                            : isSmallScreen
                            ? 22
                            : 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Responsive button layout
                    if (isSmallScreen && !isLandscape) ...[
                      // Stack buttons vertically on small screens in portrait
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Provider.of<TabProvider>(
                                  context,
                                  listen: false,
                                ).createTab();
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('New Note'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final success = await Provider.of<TabProvider>(
                                  context,
                                  listen: false,
                                ).openFile();
                                if (!success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Failed to open file'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.folder_open),
                              label: const Text('Open File'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Row layout for larger screens or landscape
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Provider.of<TabProvider>(
                                context,
                                listen: false,
                              ).createTab();
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('New Note'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () async {
                              final success = await Provider.of<TabProvider>(
                                context,
                                listen: false,
                              ).openFile();
                              if (!success && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to open file'),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.folder_open),
                            label: const Text('Open File'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
