import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/ui/themes/theme/custom_theme.dart';

class AppThemes {
 // Method to get current theme
  static CustomTheme getCurrentTheme(ThemeProvider themeProvider) {
    return themeProvider.isDarkMode ? darkTheme : lightTheme;
  }

  static CustomTheme darkTheme = CustomTheme(
    mainBackgroundPrimaryColor: const Color(0xFF02010B),
    mainBackgroundSecondaryColor: const Color(0xFF02010B),
    appPrimaryColor: const Color(0xFFCCFD14),
    appSecondaryColor: const Color(0xFFFFFFFF).withOpacity(0.15),
    appThirdColor: const Color(0xFF8194FF),
    textPrimaryColor: const Color(0xFFFFFFFF),
    textSecondaryColor: const Color(0xFF999999),
    borderColor: const Color(0xFFF0F0F0).withOpacity(0.20),
    iconColor: const Color(0xFFFFFFFF),
    hintTextColor: const Color(0xFF999999),
    errorColor: const Color(0xFFFF6492),
    highlightTextColor: const Color(0xFFCCFD14),
    secondaryButtonTextColor: const Color(0xFFFFFFFF),
    radioButtonBorderColor: const Color(0xFFF0F0F0),
    communityBoardItemColor: const Color(0xFFFFFFFF).withOpacity(0.15),
    bottomSheetBackgroundColor: const Color(0xFF3A3B41),
    transactionInfoIconColor: const Color(0xFFFFFFFF).withOpacity(0.40),
    appWhiteColor: const Color(0xFFFFFFFF),
    appBlackColor: const Color(0xFF000000),
    appGreyColor: const Color(0xFFDBD7D7),
    appDarkGreyColor: const Color(0xFF999999),
    progressBarStartColor: const Color(0xFF7A970C).withOpacity(0.20),
    imageFallbackGradientOneColor: const Color(0xFF7E8FF8),
    imageFallbackGradientTwoColor: const Color(0xFF150A71),
    appDarkGreenColor: const Color(0xFFA4D000),
    appRedColor: const Color(0xFFFF6492),
    videoCardBackgroundColor: const Color(0xFF8E919B),
    videoCardPlayIconColor: const Color(0xFFCCFD14),

  );
  static CustomTheme lightTheme = CustomTheme(
    mainBackgroundPrimaryColor: const Color(0xFFFCFCFF),
    mainBackgroundSecondaryColor: const Color(0xFF02010B),
    appPrimaryColor: const Color(0xFFCAFF02),
    appSecondaryColor: const Color(0xFFFCFCFF),
    appThirdColor: const Color(0xFF8194FF),
    textPrimaryColor: const Color(0xFF02010B),
    textSecondaryColor: const Color(0xFF999999),
    borderColor: const Color(0xFFDBD7D7),
    iconColor: const Color(0xFF02010B),
    hintTextColor: const Color(0xFF999999),
    errorColor: const Color(0xFFFF6492),
    highlightTextColor: const Color(0xFF8194FF),
    secondaryButtonTextColor: const Color(0xFF02010B),
    radioButtonBorderColor: const Color(0xFF8194FF),
    communityBoardItemColor: const Color(0xFFF6F5FF),
    bottomSheetBackgroundColor: const Color(0xFFFCFCFF),
    transactionInfoIconColor: const Color(0xFF8194FF),
    appWhiteColor:  const Color(0xFFFFFFFF),
    appBlackColor:  const Color(0xFF000000),
    appGreyColor:  const Color(0xFFDBD7D7),
    appDarkGreyColor: const Color(0xFF999999),
    progressBarStartColor: const Color(0xFF7A970C).withOpacity(0.20),
    imageFallbackGradientOneColor: const Color(0xFFF6F5FF),
    imageFallbackGradientTwoColor: const Color(0xFFDAD6FF),
    appDarkGreenColor: const Color(0xFFA4D000),
    appRedColor: const Color(0xFFFF6492),
    videoCardBackgroundColor: const Color(0xFFF6F5FF),
    videoCardPlayIconColor: const Color(0xFF02010B),
  );
}
