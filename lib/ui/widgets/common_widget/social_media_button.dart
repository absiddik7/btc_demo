import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Import your ThemeProvider
import 'package:mybtccanvas/core/utils/constants/app_assets.dart'; // For SVG icons
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:provider/provider.dart'; // For accessing the theme provider

class SocialMediaButton extends StatelessWidget {
  final SocialMediaType type;
  final VoidCallback onPressed;

  const SocialMediaButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        String assetName;
        final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        // Define asset names based on the social media type
        switch (type) {
          case SocialMediaType.facebook:
            assetName = AppAssets.facebookIcon;
            break;
          case SocialMediaType.apple:
            assetName = AppAssets.appleIcon;
            break;
          case SocialMediaType.google:
            assetName = AppAssets.googleIcon;
            break;
        }

        return GestureDetector(
          onTap: onPressed,
          child: Container(
            height: SizeConstant.buttonHeightMedium,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: borderColor,
                width: SizeConstant.borderWidthSmall,
              ),
              borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusLarge),
            ),
            child: Center(
              child: SvgPicture.asset(
                assetName,
                width: SizeConstant.iconSizeSmall,
                height: SizeConstant.iconSizeSmall,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
        );
      },
    );
  }
}
