import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Assuming you have a ThemeProvider
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:provider/provider.dart';

class DropDownMenuButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const DropDownMenuButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final borderColor = themeProvider.currentTheme.borderColor;
        final textColor = themeProvider.currentTheme.textPrimaryColor;
        final iconColor = themeProvider.currentTheme.iconColor;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(double.infinity, 56),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor, // Dynamic border color based on theme
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor, // Dynamic text color based on theme
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                AppAssets.dropdownIcon,
                colorFilter: ColorFilter.mode(
                  iconColor, // Dynamic icon color based on theme
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
