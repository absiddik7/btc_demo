import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybtccanvas/core/services/local_storage/app_sharedpreference.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/navigation_helper.dart';
import 'package:mybtccanvas/ui/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:mybtccanvas/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // Track initialization progress
  bool _isInitializationComplete = false;

  // Minimum splash duration to ensure a smooth user experience
  final Duration _minimumSplashDuration = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start initialization process
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Combine all initialization tasks
      await Future.wait([
        _checkAndPrepareSession(),
      ]);

      // Mark initialization as complete
      setState(() {
        _isInitializationComplete = true;
      });
    } catch (e) {
      // Handle initialization errors
      debugPrint('Initialization error: $e');
      setState(() {
        _isInitializationComplete = true;
      });
    }
  }

  Future<void> _checkAndPrepareSession() async {
    try {
      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Get the stored token
        String? storedIDToken = await AppSharedPreferences().getIDToken();

        if (storedIDToken != null) {
          // Validate the token
          try {
            // Attempt to get a new token, which will throw an error if the session is invalid
            await currentUser.getIdToken(true);
            // Additional session preparation can be added here
            return;
          } catch (e) {
            // Token is invalid or expired
            await FirebaseAuth.instance.signOut();
            await AppSharedPreferences().removeIDToken();
          }
        }
      }
    } catch (e) {
      debugPrint('Session preparation error: $e');
    }
  }

  Future<void> _navigateAfterInitialization() async {
    // Ensure minimum splash duration
    final stopwatch = Stopwatch()..start();

    // Wait for initialization to complete
    while (!_isInitializationComplete) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // Ensure minimum splash duration is met
    final elapsedTime = stopwatch.elapsed;
    if (elapsedTime < _minimumSplashDuration) {
      await Future.delayed(_minimumSplashDuration - elapsedTime);
    }

    // Navigate to appropriate screen
    if (!mounted) return;

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String? storedIDToken = await AppSharedPreferences().getIDToken();
        if (storedIDToken != null) {
          await currentUser.getIdToken(true);
          if (!mounted) return;
          NavigationHelper.navigateToReplacement(context, const BottomBarScreen());
          return;
        }
      }

      // If no valid session
      if (!mounted) return;
      NavigationHelper.navigateToReplacement(context, const WelcomeScreen());
    } catch (e) {
      // Handle any unexpected errors
      if (!mounted) return;
      NavigationHelper.navigateToReplacement(context, const WelcomeScreen());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Trigger navigation after initialization
    _navigateAfterInitialization();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: CustomBackground(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    AppAssets.myBitcoinCanvasLogo,
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.width * 0.75,
                  ),
                ),
                // Optional: Add a loading indicator
                if (!_isInitializationComplete)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}