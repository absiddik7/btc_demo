import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/auth/signin_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/message_service.dart';
import 'package:mybtccanvas/core/utils/navigation_helper.dart';
import 'package:mybtccanvas/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:provider/provider.dart';

class LogoutBottomSheet extends StatefulWidget {
  const LogoutBottomSheet({super.key});

  @override
  State<LogoutBottomSheet> createState() => _LogoutBottomSheetState();
}

class _LogoutBottomSheetState extends State<LogoutBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, SignInProvider>(
      builder: (context, themeProvider, signInProvider, _) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                decoration: themeProvider.isDarkMode
                    ? BoxDecoration(
                        color: const Color(0xFFCCFD14),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFCCFD14).withOpacity(0.15), // Neon glow color
                            spreadRadius: 16,
                            blurRadius: 24,
                            offset: const Offset(0, -8), // Shadow position
                          ),
                        ],
                      )
                    : null,
                child: Image.asset(
                  AppAssets.logoutImg,
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Logout',
                style: AppTextStyles.outfitSB40(color: textColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to log out?',
                style: AppTextStyles.outfitSB16(color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.secondary,
                      label: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.primary,
                      label: 'Yes, log out',
                      onPressed: () async {
                        try {
                          await signInProvider.logout();
                          // Navigate back to the login screen
                          if (!context.mounted) return;
                          NavigationHelper.navigateToReplacement(context, const WelcomeScreen());
                        } catch (e) {
                          // Show error message
                          MessageService.showError(context, e.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
