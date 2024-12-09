import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Import the ThemeProvider
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart'; // For accessing the Provider

class AchievementsItem extends StatelessWidget {
  final IconData icon; // Replacing this with SvgPicture or Icon based on theme
  final String title;
  final String subtitle;

  const AchievementsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      // Get theme colors dynamically
      final Color cardBackgroundColor = themeProvider.currentTheme.appSecondaryColor; // For background
      final Color textColor = themeProvider.currentTheme.textPrimaryColor; // For text
      final Color subtitleColor = themeProvider.currentTheme.textSecondaryColor; // For subtitle
      final Color iconColor = themeProvider.currentTheme.iconColor; // For icon
      final Color borderColor = themeProvider.currentTheme.borderColor; // For border

      return Container(
        width: SizeConstant.achivementContainerHeight,
        padding: const EdgeInsets.all(SizeConstant.paddingMedium),
        decoration: BoxDecoration(
          color: cardBackgroundColor, // Card color from the theme
          border: Border.all(
            color: borderColor, // Border color from the theme
            width: SizeConstant.borderWidthSmall,
          ),
          borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dynamically setting the icon using SvgPicture
            SvgPicture.asset(
              AppAssets.trophyIcon, // Assuming this is an SVG icon
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              height: SizeConstant.iconSizeMedium,
              width: SizeConstant.iconSizeMedium,
            ),
            const SizedBox(height: SizeConstant.spaceSmall),
            Text(
              title,
              style: AppTextStyles.outfitSB16(
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SizeConstant.spaceExtraSmall),
            Text(
              subtitle,
              style: AppTextStyles.urbanistR14(
                color: subtitleColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }
}
