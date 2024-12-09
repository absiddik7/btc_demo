import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';

class FullBlockInsights extends StatelessWidget {
  final String text;

  const FullBlockInsights({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Access colors from the current theme
        final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final Color highlightColor = themeProvider.currentTheme.highlightTextColor;
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: backgroundColor, 
            border: Border.all(
              color: borderColor, 
              width: 0.5,
            ),  
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Insights: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: highlightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: text,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
