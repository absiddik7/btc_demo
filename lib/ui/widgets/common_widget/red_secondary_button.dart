import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class RedSecondaryButton extends StatefulWidget {
  final String title;
  final Function() onPressed;
  const RedSecondaryButton({super.key, required this.title, required this.onPressed});

  @override
  State<RedSecondaryButton> createState() => _RedSecondaryButtonState();
}

class _RedSecondaryButtonState extends State<RedSecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final cardColor = themeProvider.currentTheme.appSecondaryColor;
          final borderColor = themeProvider.currentTheme.borderColor;
          final textColor = themeProvider.currentTheme.errorColor;

          return Container(
            width: double.infinity,
            height: SizeConstant.buttonHeightLarge,
            decoration: BoxDecoration(
              color: cardColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusLarge),
            ),
            child: Center(
              child: Text(
                widget.title,
                style: AppTextStyles.outfitR16(
                  color: textColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}