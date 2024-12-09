import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';

class NewsChipsButton extends StatelessWidget {
  final ThemeProvider themeProvider;
  final String title;
  final Color bgColor;
  final Color textColor;
  const NewsChipsButton({super.key, required this.themeProvider, required this.title, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(title, style: AppTextStyles.urbanistB14(color: textColor),),
    );
  }
}