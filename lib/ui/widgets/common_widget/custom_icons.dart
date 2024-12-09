import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:provider/provider.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconButtonType type;

  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Access theme properties from ThemeProvider
        final Widget iconWidget;
        final Color iconColor = themeProvider.currentTheme.iconColor;
        final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final borderColor = themeProvider.currentTheme.borderColor;

        // Define properties based on the buttonType and theme
        switch (type) {
          case IconButtonType.playButton:
            iconWidget = SvgPicture.asset(
              AppAssets.playIcon,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 24,
              height: 24,
            );
            break;
          case IconButtonType.popButton:
            iconWidget = Icon(
              Icons.arrow_back,
              color: iconColor,
              size: 24,
            );
            break;
        }

        return GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 0.5),
            ),
            child: Center(
              child: iconWidget,
            ),
          ),
        );
      },
    );
  }
}
