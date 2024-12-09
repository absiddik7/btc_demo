import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/models/discover/course_model.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  final bool isPopularCourse;
  final CourseModel courseModel;

  const CourseCard({
    super.key,
    required this.isPopularCourse,
    required this.courseModel,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: themeProvider.currentTheme.appSecondaryColor,
            borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
            border: Border.all(color: themeProvider.currentTheme.borderColor, width: SizeConstant.borderWidthSmall),
          ),
          padding: const EdgeInsets.all(SizeConstant.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.courseModel.courseTitle,
                      style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: SizeConstant.paddingExtraSmall, vertical: SizeConstant.paddingExtraSmall/2),
                    decoration: BoxDecoration(
                      color: themeProvider.currentTheme.appThirdColor, 
                      borderRadius: BorderRadius.circular(SizeConstant.paddingExtraSmall), 
                    ),
                    child: Text(
                      widget.courseModel.courseCategory,
                      style: AppTextStyles.urbanistB14(color: themeProvider.currentTheme.appWhiteColor),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: SizeConstant.spaceSmall), 

              widget.isPopularCourse? Text(
                widget.courseModel.courseSubtitle,	
                style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ): Container(),

              const SizedBox(height: SizeConstant.spaceSmall), 

              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.timerIcon,
                    width: SizeConstant.iconSizeSmall,
                    height: SizeConstant.iconSizeSmall,
                    //colorFilter: ColorFilter.mode(themeProvider.currentTheme.appPrimaryColor , BlendMode.srcIn),
                  ),
                  const SizedBox(width: SizeConstant.paddingExtraSmall),
                  Text(
                    "${widget.courseModel.totalDuration%1==0?widget.courseModel.totalDuration.toInt():widget.courseModel.totalDuration} ${context.lang.hours}",
                    style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                  ),
                ],
              ),

              const SizedBox(height: SizeConstant.spaceSmall), 

              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.videoCameraIcon,
                    width: SizeConstant.iconSizeSmall,
                    height: SizeConstant.iconSizeSmall,
                    //colorFilter: ColorFilter.mode(themeProvider.currentTheme.appPrimaryColor , BlendMode.srcIn),
                  ),
                  const SizedBox(width: SizeConstant.paddingExtraSmall),
                  Text(
                    "${widget.courseModel.numberOfVideos} ${context.lang.videos}",
                    style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                  ),
                ],
              ),

              const SizedBox(height: SizeConstant.spaceMedium), 

              widget.isPopularCourse? Container(
                width: MediaQuery.of(context).size.width*0.6,
                height: 34,
                padding: const EdgeInsets.all(SizeConstant.paddingExtraSmall),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: themeProvider.currentTheme.communityBoardItemColor,
                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusSmall),
                  border: Border.all(color: themeProvider.currentTheme.borderColor, width: SizeConstant.borderWidthSmall),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${context.lang.join} ${widget.courseModel.numberOfUsers?? ""}+ ${context.lang.users}",
                          style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: widget.courseModel.enrolledUserImages!.isNotEmpty? Container(
                        alignment: Alignment.centerRight,
                        child: Stack(
                          children: [
                            widget.courseModel.enrolledUserImages!.isNotEmpty? Positioned(
                              //left: SizeConstant.popularCourseUserStackDiff * 0,
                              right: SizeConstant.popularCourseUserStackDiff * 0,
                              child: buildUserImage(context, widget.courseModel.enrolledUserImages![0], themeProvider)
                            ) : Container(),
                            widget.courseModel.enrolledUserImages!.length > 1? Positioned(
                              //left: SizeConstant.popularCourseUserStackDiff * 1,
                              right: SizeConstant.popularCourseUserStackDiff * 1,
                              child: buildUserImage(context, widget.courseModel.enrolledUserImages![1], themeProvider)
                            ) : Container(),
                            widget.courseModel.enrolledUserImages!.length > 2? Positioned(
                              //left: SizeConstant.popularCourseUserStackDiff * 2,
                              right: SizeConstant.popularCourseUserStackDiff * 2,
                              child: buildUserImage(context, widget.courseModel.enrolledUserImages![2], themeProvider)
                            ) : Container(),
                            widget.courseModel.enrolledUserImages!.length > 3? Positioned(
                              //left: SizeConstant.popularCourseUserStackDiff * 3,
                              right: SizeConstant.popularCourseUserStackDiff * 3,
                              child: buildUserImage(context, widget.courseModel.enrolledUserImages![3], themeProvider)
                            ) : Container(),
                            widget.courseModel.enrolledUserImages!.length > 4? Positioned(
                              //left: SizeConstant.popularCourseUserStackDiff * 4,
                              right: SizeConstant.popularCourseUserStackDiff * 4,
                              child: buildUserImage(context, widget.courseModel.enrolledUserImages![4], themeProvider)
                            ) : Container(),
                          ],
                        ),
                      ) : Container(),
                    )
                  ],
                ),
              ) : ClipRRect(
                borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                child: LinearProgressIndicator(
                  value: widget.courseModel.courseProgress,
                  color: themeProvider.currentTheme.appPrimaryColor,
                  backgroundColor: themeProvider.currentTheme.appGreyColor, 
                  minHeight: SizeConstant.linearProgressBarHeight, 
                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUserImage(BuildContext context, String? imageUrl, ThemeProvider themeProvider) {
    return Container(
      alignment: Alignment.center,
      height: SizeConstant.iconSizeMedium,
      width: SizeConstant.iconSizeMedium,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: themeProvider.currentTheme.appWhiteColor, 
          width: SizeConstant.borderWidthLarge,
        ),
      ),
      child: CircleAvatar(
        radius: (SizeConstant.iconSizeMedium - SizeConstant.borderWidthLarge) / 2,
        backgroundImage: NetworkImage(imageUrl!),
      ),
    );
  }
}