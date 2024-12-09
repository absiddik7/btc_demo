import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/models/discover/course_model.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/image_error_fallback.dart';
import 'package:provider/provider.dart';

class CourseCardTwo extends StatefulWidget {
  final CourseModel courseModel;

  const CourseCardTwo({
    super.key,
    required this.courseModel,
  });

  @override
  State<CourseCardTwo> createState() => _CourseCardTwoState();
}

class _CourseCardTwoState extends State<CourseCardTwo> {
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
              Container(
                height: 82,
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      height: 82,
                      width: 82,
                      padding: const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.courseModel.courseThumbnail, 
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const ImageErrorFallback();
                          },
                                
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return const ImageErrorFallback();
                          },
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: SizeConstant.paddingSmall, top: SizeConstant.paddingExtraSmall, bottom: SizeConstant.paddingExtraSmall),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.courseModel.courseTitle,
                                        style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: SizeConstant.paddingExtraSmall, vertical: SizeConstant.paddingExtraSmall/2),
                                      decoration: BoxDecoration(
                                        color: themeProvider.currentTheme.appThirdColor, 
                                        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusExtraSmall), 
                                      ),
                                      child: Text(
                                        widget.courseModel.courseCategory,
                                        style: AppTextStyles.urbanistB14(color: themeProvider.currentTheme.appWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  widget.courseModel.courseSubtitle,	
                                  style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.transparent,
                height: 40,
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.timerIcon,
                      width: SizeConstant.iconSizeSmall,
                      height: SizeConstant.iconSizeSmall,
                      //colorFilter: ColorFilter.mode(themeProvider.currentTheme.appPrimaryColor , BlendMode.srcIn),
                    ),
                    const SizedBox(width: SizeConstant.spaceExtraSmall),
                    Text(
                      "${widget.courseModel.totalDuration % 1 == 0 ? widget.courseModel.totalDuration.toInt() : widget.courseModel.totalDuration} ${context.lang.hours}",
                      style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                    ),
                
                    const SizedBox(width: SizeConstant.spaceMedium),
                
                    SvgPicture.asset(
                      AppAssets.videoCameraIcon,
                      width: SizeConstant.iconSizeSmall,
                      height: SizeConstant.iconSizeSmall,
                      //colorFilter: ColorFilter.mode(themeProvider.currentTheme.appPrimaryColor , BlendMode.srcIn),
                    ),
                    const SizedBox(width: SizeConstant.spaceExtraSmall),
                    Text(
                      "${widget.courseModel.numberOfVideos} ${context.lang.videos}",
                      style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                    ),
                
                    const SizedBox(width: SizeConstant.spaceMedium),
              
                    SvgPicture.asset(
                      AppAssets.videoCameraIcon,
                      width: SizeConstant.iconSizeSmall,
                      height: SizeConstant.iconSizeSmall,
                      //colorFilter: ColorFilter.mode(themeProvider.currentTheme.appPrimaryColor , BlendMode.srcIn),
                    ),
                    const SizedBox(width: SizeConstant.spaceExtraSmall),
                    Text(
                      "Join ${widget.courseModel.numberOfUsers?? ""}+ ${context.lang.users}",
                      style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.textPrimaryColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
              const SizedBox(height: SizeConstant.spaceExtraSmall),
            ],
          ),
        );
      },
    );
  }
}