import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Import your ThemeProvider
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:provider/provider.dart'; // For accessing the theme provider

class SecondaryIconButton extends StatelessWidget {
  final SecondaryIconButtonType type;
  final String label;
  final VoidCallback? onPressed;

  const SecondaryIconButton({
    super.key,
    required this.type,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        String assetName;
        final Color backgroundColor =
            themeProvider.currentTheme.appSecondaryColor;
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        switch (type) {
          case SecondaryIconButtonType.photoUploadButton:
            assetName = AppAssets.uploadPhotoIcon;
            break;
          case SecondaryIconButtonType.addButton:
            assetName = AppAssets.addIcon;
            break;
          case SecondaryIconButtonType.deleteButton:
            assetName = AppAssets.deleteIcon;
            break;
        }

        return ElevatedButton.icon(
          icon: SvgPicture.asset(
            assetName,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          label: Text(
            label,
            style: TextStyle(
              color: textColor,
              inherit: true,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            elevation: 0,
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: themeProvider.currentTheme.borderColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: onPressed,
        );
      },
    );
  }
}
