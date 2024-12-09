import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart'; // Ensure this is imported for access to Provider

class MessageService {
  // Method to show success messages
  static void showSuccess(BuildContext context, String message) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false); // Access ThemeProvider

    final snackBar = SnackBar(
      content: Text(
        message,
        style: AppTextStyles.outfitR16(color: themeProvider.currentTheme.appBlackColor),
      ),
      backgroundColor: themeProvider.currentTheme.appDarkGreenColor,
      margin: const EdgeInsets.all(SizeConstant.marginMedium),
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMiniMedium),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Method to show error messages
  static void showError(BuildContext context, String message) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false); // Access ThemeProvider

    final snackBar = SnackBar(
      content: Text(
        message,
        style: AppTextStyles.outfitR16(color: themeProvider.currentTheme.appWhiteColor),
      ),
      backgroundColor: themeProvider.currentTheme.appRedColor,
      margin: const EdgeInsets.all(SizeConstant.marginMedium),
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMiniMedium),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Method to show custom messages (if you need more control over the UI)
  static void showMessage(BuildContext context, String message, {Color? backgroundColor, Color? textColor}) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false); // Access ThemeProvider
    final customColor = backgroundColor ?? themeProvider.currentTheme.appPrimaryColor;
    final customTextColor = textColor ?? themeProvider.currentTheme.appBlackColor;

    final snackBar = SnackBar(
      content: Text(
        message,
        style: AppTextStyles.outfitR16(color: customTextColor),
      ),
      backgroundColor: customColor,
      margin: const EdgeInsets.all(SizeConstant.marginMedium),
      padding: const EdgeInsets.all(SizeConstant.paddingMedium),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMiniMedium),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
