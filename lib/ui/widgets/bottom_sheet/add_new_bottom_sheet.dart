import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class AddNewBottomSheet extends StatelessWidget {
  const AddNewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color backgroundColor = themeProvider.currentTheme.communityBoardItemColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add new',
                style: AppTextStyles.outfitSB24(color: textColor),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First Container
                  Expanded(
                    child: Container(
                      height: 91,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(color: borderColor, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.addWidgetIcon,
                            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Add widget",
                            style: AppTextStyles.outfitR16(color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Second Container
                  Expanded(
                    child: Container(
                      height: 91,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(color: borderColor, width: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.addBoardIcon,
                            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Add board",
                            style: AppTextStyles.outfitR16(color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Third Container Below the Two
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.addcommunityBoardImg,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Community boards",
                      style: AppTextStyles.outfitR16(color: textColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
