import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/auth/signin/signin_screen.dart';
import 'package:mybtccanvas/ui/screens/auth/signup/signup_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        // Exit the app if the back button is pressed
        if (Platform.isAndroid || Platform.isIOS) {
          exit(0);
        }
      },
      child: Scaffold(
        body: CustomBackground(
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              final Color primaryTextColor = themeProvider.currentTheme.textPrimaryColor;

              return LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SizeConstant.appHorizontalPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo Section - Take up approximately 45% of the screen
                          Expanded(
                            flex: 45,
                            child: _buildLogo(themeProvider),
                          ),

                          // Content Section - Take up approximately 55% of the screen
                          Expanded(
                            flex: 55,
                            child: _buildContent(primaryTextColor, context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Logo Section
  Widget _buildLogo(ThemeProvider themeProvider) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        AppAssets.myBitcoinCanvasLogo,
        height: 260,
        fit: BoxFit.contain,
      ),
    );
  }

  // Content Section
  Widget _buildContent(Color primaryTextColor, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          context.lang.welcome_title,
          style: AppTextStyles.outfitSB40(
            color: primaryTextColor,
            height: 1.0,
          ),
        ),

        const SizedBox(height: SizeConstant.spaceMedium),

        // Subtitle
        Text(
          context.lang.welcome_subtitle,
          style: AppTextStyles.interR16(color: primaryTextColor),
        ),

        const SizedBox(height: SizeConstant.spaceExtraLarge),

        // Sign In Button
        SizedBox(
          width: double.infinity,
          child: CommonButton(
            type: ButtonType.primary,
            label: context.lang.signin,
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const SigninScreen(),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: SizeConstant.spaceMedium),

        // Sign Up Button
        SizedBox(
          width: double.infinity,
          child: CommonButton(
            type: ButtonType.secondary,
            label: context.lang.signup,
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: SizeConstant.spaceMedium),
      ],
    );
  }
}
