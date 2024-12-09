import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class ProfileItem extends StatelessWidget {
  final String leadingSVGIcon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileItem({
    super.key,
    required this.leadingSVGIcon,
    required this.title,
    required this.onTap,
    this.showDivider = true, // By default, the divider is visible
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      // Listening to the ThemeProvider
      builder: (context, themeProvider, child) {
        final textColor = themeProvider.currentTheme.textPrimaryColor;
        final borderColor = themeProvider.currentTheme.borderColor;
        final iconColor = themeProvider.currentTheme.highlightTextColor;
        final arrowColor = themeProvider.currentTheme.textSecondaryColor;

        return Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: SizeConstant.paddingMedium, horizontal: SizeConstant.paddingLarge),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      leadingSVGIcon,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                      height: SizeConstant.iconSizeMedium,
                      width: SizeConstant.iconSizeMedium,
                    ),
                    const SizedBox(width: SizeConstant.spaceMedium),
                    Expanded(
                      child: Text(title, style: AppTextStyles.urbanistR14(color: textColor)),
                    ),
                    SvgPicture.asset(
                      AppAssets.iosRightArrowIcon,
                      colorFilter: ColorFilter.mode(arrowColor, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
            // Show the divider conditionally based on the 'showDivider' property
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(left: SizeConstant.spaceExtraLarge),
                child: Divider(
                  color: borderColor,
                  height: SizeConstant.borderWidthSmall,
                  thickness: SizeConstant.borderWidthSmall,
                ),
              ),
          ],
        );
      },
    );
  }
}
