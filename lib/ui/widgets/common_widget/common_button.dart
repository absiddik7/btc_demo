import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CommonButton extends StatelessWidget {
  final ButtonType type;
  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const CommonButton({
    super.key,
    required this.type,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Access theme properties from ThemeProvider
        final Color primaryButtonColor =
            themeProvider.currentTheme.appPrimaryColor;
        final Color secondaryButtonColor =
            themeProvider.currentTheme.appSecondaryColor;
        final Color primaryButtonDisabledColor =
            themeProvider.currentTheme.appPrimaryColor.withOpacity(0.5);
        final Color secondaryButtonDisabledColor =
            themeProvider.currentTheme.appSecondaryColor.withOpacity(0.5);
        final Color secondaryButtonBorderColor =
            themeProvider.currentTheme.borderColor;
        final Color primaryButtonTextColor =
            themeProvider.currentTheme.mainBackgroundSecondaryColor;
        final Color secondaryButtonTextColor =
            themeProvider.currentTheme.textPrimaryColor;

        // Determine text color based on button type and state
        final Color textColor = type == ButtonType.primary
            ? primaryButtonTextColor
            : secondaryButtonTextColor;

        final ButtonStyle buttonStyle = ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 56)),
          padding: WidgetStateProperty.all(
            const EdgeInsets.only(top: 12, bottom: 12, left: 32, right: 32),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return type == ButtonType.primary
                    ? primaryButtonDisabledColor
                    : secondaryButtonDisabledColor;
              }
              return type == ButtonType.primary
                  ? primaryButtonColor
                  : secondaryButtonColor;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return textColor.withOpacity(0.5);
              }
              return textColor;
            },
          ),
          // Adding a border for secondary button
          side: WidgetStateProperty.resolveWith<BorderSide>(
            (Set<WidgetState> states) {
              if (type == ButtonType.secondary) {
                return BorderSide(
                  color: secondaryButtonBorderColor,
                  width: 0.5,
                );
              }
              return BorderSide.none;
            },
          ),
        );

        return ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: buttonStyle,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        );
      },
    );
  }
}
