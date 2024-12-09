import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/models/discover/course_model.dart';
import 'package:mybtccanvas/core/providers/discover/discover_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/discover/course/course_card_two.dart';
import 'package:mybtccanvas/ui/screens/discover/discover_explore/content_stack.dart';
import 'package:mybtccanvas/ui/screens/discover/quiz/quize_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatefulWidget {
  final CourseModel courseModel;
  final bool isActiveCourse;
  const CourseDetailScreen({super.key, required this.courseModel, required this.isActiveCourse});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiscoverProvider>(context, listen: false).initVideoDescExpand(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<ThemeProvider, DiscoverProvider>(
          builder: (context, themeProvider, discoverProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // custom app bar with container, back button and title
                CustomAppBar(
                  title: context.lang.course_details,
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: SizeConstant.appVerticalPadding),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,   
                              children: [
                                CourseCardTwo(courseModel: widget.courseModel),
                                const SizedBox(height: SizeConstant.spaceLarge),
                                Text(
                                  widget.courseModel.courseSubtitle,
                                  style:
                                      AppTextStyles.outfitR16(color: themeProvider.currentTheme.textPrimaryColor),
                                ),
                                const SizedBox(height: SizeConstant.spaceLarge),
                              ],
                            ),
                          ),
                          Container(
                              height: SizeConstant.stackContainerHeight + 28.0,
                              width: double.infinity,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: ContentStack(
                                courseContentList: discoverProvider.contentList,
                                containerHeight: SizeConstant.stackContainerHeight,
                              )),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.isActiveCourse? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CommonButton(
                                        type: ButtonType.secondary,
                                        label: context.lang.take_a_quiz,
                                        onPressed: () {
                                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const QuizScreen()));
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: SizeConstant.spaceSmall,
                                    ),
                                    Expanded(
                                      child: CommonButton(
                                        type: ButtonType.secondary,
                                        label: context.lang.next_course,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                )
                                 : Container(),
                                
                                SizedBox(height: widget.isActiveCourse? SizeConstant.spaceLarge : 0),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: themeProvider.currentTheme.appSecondaryColor,
                                    borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                                    border: Border.all(
                                        color: themeProvider.currentTheme.borderColor,
                                        width: SizeConstant.borderWidthSmall),
                                  ),
                                  padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.courseModel.sections[0].videos[0].videoTitle,
                                        style: AppTextStyles.outfitSB16(
                                            color: themeProvider.currentTheme.textPrimaryColor),
                                      ),
                                      const SizedBox(height: SizeConstant.spaceMedium),
                                      Text(
                                        widget.courseModel.sections[0].videos[0].videoDescription,
                                        style: AppTextStyles.urbanistR14(
                                            color: themeProvider.currentTheme.textPrimaryColor),
                                        maxLines: discoverProvider.isVideoDescExpandMore ? null : 3,
                                        overflow: discoverProvider.isVideoDescExpandMore
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: SizeConstant.spaceLarge),
                                      CommonButton(
                                        type: ButtonType.secondary,
                                        label: discoverProvider.isVideoDescExpandMore? context.lang.expand_less : context.lang.expand_more,
                                        onPressed: () {
                                          discoverProvider.toggleVideoDescExpanded();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
