import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/discover/discover_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:provider/provider.dart';

class CompleteQuizBottomSheet extends StatelessWidget {
  final String quizTitle;
  final int correctAnswers;
  final int incorrectAnswers;
  final VoidCallback onPressedFished;
  final VoidCallback onPressedNextCourse;
  const CompleteQuizBottomSheet({super.key, required this.onPressedFished, required this.onPressedNextCourse, required this.quizTitle, required this.correctAnswers, required this.incorrectAnswers});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color backgroundColor = themeProvider.currentTheme.communityBoardItemColor;
        final Color chipsColor = themeProvider.currentTheme.appThirdColor;
        return Container(
          padding: const EdgeInsets.all(SizeConstant.paddingSmall),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: SizeConstant.spaceMedium),
              Image.asset(
                AppAssets.correctQuizImg,
                width: 86,
                height: 72,
              ),
              Text(context.lang.quiz_completed, style: AppTextStyles.outfitSB40(color: textColor)),
              const SizedBox(height: SizeConstant.spaceMedium),
              Center(
                child: Text(quizTitle,
                    textAlign: TextAlign.center, style: AppTextStyles.outfitR16(color: textColor)),
              ),
              const SizedBox(height: SizeConstant.spaceMedium),
              // Quiz result
              Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                ),
                padding: const EdgeInsets.all(SizeConstant.paddingSmall),
                child: Padding(
                  padding: const EdgeInsets.all(SizeConstant.paddingSmall),
                  child: Column(
                    children: [
                      // Correct answers
                      Row(
                        children: [
                          Expanded(
                            child: Text(context.lang.correct_answers, style: AppTextStyles.outfitR16(color: textColor)),
                          ),
                          Text(correctAnswers.toString(), style: AppTextStyles.outfitSB16(color: textColor)),
                        ],
                      ),
                      const SizedBox(height:SizeConstant.spaceSmall),
                      const Divider(),
                      const SizedBox(height: SizeConstant.spaceSmall),
                      // Incorrect answers
                      Row(
                        children: [
                          Expanded(
                            child:
                                Text(context.lang.incorrect_answers, style: AppTextStyles.outfitR16(color: textColor)),
                          ),
                          Text(incorrectAnswers.toString(), style: AppTextStyles.outfitSB16(color: textColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: SizeConstant.spaceMedium),
              // points
              Container(
                margin: const EdgeInsets.symmetric(horizontal: SizeConstant.marginLarge),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.watch<DiscoverProvider>().getPerformanceLabel(context, correctAnswers, (correctAnswers + incorrectAnswers)), style: AppTextStyles.outfitSB16(color: textColor)),
                    Container(
                        decoration: BoxDecoration(
                          color: chipsColor,
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusSmall),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SizeConstant.paddingSmall, vertical: SizeConstant.paddingExtraSmall),
                          child: Text('${correctAnswers * 5}/${(correctAnswers + incorrectAnswers) * 5} ${context.lang.points}', style: AppTextStyles.outfitB14(color: themeProvider.currentTheme.appWhiteColor)),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: SizeConstant.spaceMedium),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.secondary,
                      label: context.lang.finish_and_Close,
                      onPressed: onPressedFished
                    ),
                  ),
                  const SizedBox(width: SizeConstant.spaceSmall),
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.primary,
                      label: context.lang.next_course,
                      onPressed: onPressedNextCourse
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SizeConstant.spaceSmall),
            ],
          ),
        );
      },
    );
  }
}
