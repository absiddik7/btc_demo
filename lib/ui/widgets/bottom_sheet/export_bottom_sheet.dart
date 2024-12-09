import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class ExportBottomSheet extends StatelessWidget {
  const ExportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color backgroundColor =
            themeProvider.currentTheme.communityBoardItemColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Export',
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
                            AppAssets.documentIcon,
                            colorFilter:
                                ColorFilter.mode(iconColor, BlendMode.srcIn),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "CSV",
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
                            AppAssets.documentIcon,
                            colorFilter:
                                ColorFilter.mode(iconColor, BlendMode.srcIn),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Google sheet",
                            style: AppTextStyles.outfitR16(color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
            ],
          ),
        );
      },
    );
  }
}
