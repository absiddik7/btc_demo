import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/custom_painter/circular_gradient_progress_painter.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          height: SizeConstant.discoverUserContainerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: themeProvider.currentTheme.appSecondaryColor,
            borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
            border: Border.all(color: themeProvider.currentTheme.borderColor, width: SizeConstant.borderWidthSmall),
          ),
          padding: const EdgeInsets.all(SizeConstant.paddingMedium),
          child: Column(
            children: [
              Expanded(
                  child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: CustomPaint(
                          painter: CircularGradientPainter(
                              progress: 0.7,
                              circleRadius: 24,
                              strokeWidth: 2.0,
                              startColor: themeProvider.currentTheme.progressBarStartColor,
                              endColor: themeProvider.currentTheme.appPrimaryColor,
                              backgroundColor: Colors.transparent),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(AppAssets.celebrateImg),
                            radius: SizeConstant.cornerRadiusMedium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: SizeConstant.spaceMedium),
                    Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Jason Wilson",
                                  style: AppTextStyles.outfitSB24(
                                      color: themeProvider.currentTheme.textPrimaryColor),
                                ),
                                const SizedBox(width: SizeConstant.spaceSmall),
                                SvgPicture.asset(
                                  AppAssets.trophyIcon,
                                  width: SizeConstant.iconSizeMedium,
                                  height: SizeConstant.iconSizeMedium,
                                  //colorFilter: ColorFilter.mode(themeProvider.currentTheme.appPrimaryColor , BlendMode.srcIn),
                                ),
                              ],
                            ),
                            Text(
                              "Advanced learner",
                              style: AppTextStyles.interR16(
                                  color: themeProvider.currentTheme.textSecondaryColor),
                            ),
                          ],
                        )),
                  ],
                ),
              )),
              const SizedBox(height: SizeConstant.spaceMedium),
              Expanded(
                  child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: buildPointsActiveCourse(
                            context, themeProvider, context.lang.total_points, "12300 xp", AppAssets.totalPointsIcon)),
                    const SizedBox(width: SizeConstant.spaceMedium),
                    Expanded(
                        child: buildPointsActiveCourse(
                            context, themeProvider, context.lang.active_course, "12", AppAssets.activeCourseIcon)),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  Widget buildPointsActiveCourse(
      BuildContext context, ThemeProvider themeProvider, String title, String value, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(SizeConstant.paddingSmall),
      decoration: BoxDecoration(
        color: themeProvider.currentTheme.communityBoardItemColor,
        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMiniMedium),
        border: Border.all(color: themeProvider.currentTheme.borderColor, width: SizeConstant.borderWidthSmall),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            width: SizeConstant.iconSizeMedium,
            height: SizeConstant.iconSizeMedium,
            //colorFilter: ColorFilter.mode(themeProvider.currentTheme.appPrimaryColor , BlendMode.srcIn),
          ),
          const SizedBox(width: SizeConstant.spaceSmall),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textSecondaryColor),
              ),
              Text(
                value,
                style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
