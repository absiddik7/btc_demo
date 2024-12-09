import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, // Required for animations
    )..repeat(reverse: true); // Make the animation repeat and reverse

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false); // Access ThemeProvider

    return PopScope(
      canPop: false, // Prevent back button from dismissing
      child: Scaffold(
        backgroundColor: themeProvider.currentTheme.appBlackColor.withOpacity(0.30),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Apply the scale animation to the logo
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value, // Apply the scaling animation
                    child: child,
                  );
                },
                child: Image.asset(
                  AppAssets.myBitcoinCanvasLogo,
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.width * 0.75,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAppLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (_) => const LoadingScreen(),
  );
}

void hideAppLoading(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
}
