import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mybtccanvas/core/providers/discover/discover_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/discover/quiz/qopt_card.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/complete_quiz_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/correct_quiz_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/incorrect_quiz_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/parent_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/bordered_circular_progress.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // Reset the quiz state when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiscoverProvider>(context, listen: false).resetQuiz();
      _pageController.jumpToPage(0); // Ensure the page view resets to the first page
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = SizeConstant.iconSizeLarge - 2;
    double totalStrokeWidth = 5.0;
    double borderStrokeWidth = 0.5;

    return Scaffold(
      body: CustomBackground(
        child: Consumer2<ThemeProvider, DiscoverProvider>(
          builder: (context, themeProvider, discoverProvider, _) {
            int currentQuestionIndex = discoverProvider.currentQuestionIndex;
            var currentQuestion = discoverProvider.quizList[0].questions[currentQuestionIndex];
            int totalQuestions = discoverProvider.quizList[0].questions.length;
            double progress = (currentQuestionIndex + 1) / totalQuestions;
            //int questionId = currentQuestion.questionId; // Assuming each question has a unique ID

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar with progress indicator
                CustomAppBar(
                  title: context.lang.quiz,
                  trailingIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${currentQuestionIndex + 1}/$totalQuestions',
                        style: AppTextStyles.outfitSB16(
                            color: themeProvider.currentTheme.textPrimaryColor),
                      ),
                      const SizedBox(width: SizeConstant.spaceSmall),
                      BorderedCircularProgress(
                        iconSize: iconSize,
                        progress: progress,
                        totalStrokeWidth: totalStrokeWidth,
                        borderStrokeWidth: borderStrokeWidth,
                        progressColor: themeProvider.currentTheme.appPrimaryColor,
                        backgroundColor: themeProvider.isDarkMode
                            ? themeProvider.currentTheme.appSecondaryColor
                            : themeProvider.currentTheme.textSecondaryColor,
                        borderColor: themeProvider.isDarkMode
                            ? themeProvider.currentTheme.borderColor
                            : themeProvider.currentTheme.appGreyColor,
                      ),
                    ],
                  ),
                ),

                // PageView for questions
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: totalQuestions,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      discoverProvider.updateQuestionIndex(index);
                    },
                    itemBuilder: (context, index) {
                      var question = discoverProvider.quizList[0].questions[index];
                      int selectedOptionIndex = discoverProvider.getSelectedAnswer(question.questionId); // Retrieve the stored answer by questionId

                      return SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SizeConstant.appHorizontalPadding,
                            vertical: SizeConstant.appVerticalPadding,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question Card
                              FadeIn(
                                duration: const Duration(milliseconds: 400),
                                child: QandOptCard(
                                  //imageUrl: question.questionImageUrl,
                                  title: question.question,
                                  isQuestion: true,
                                ),
                              ),

                              // Options displayed in grid view
                              AnimationLimiter(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: question.options.length,
                                  itemBuilder: (context, optionIndex) {
                                    var option = question.options[optionIndex];
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 400),
                                      child: SlideAnimation(
                                        //horizontalOffset: 50.0,
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () {
                                              discoverProvider.selectAnswer(question.questionId, optionIndex); // Store selected answer by questionId
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: SizeConstant.spaceMedium),
                                              child: QandOptCard(
                                                title: option.answerText,
                                                //imageUrl: option.answerImageUrl,
                                                isQuestion: false,
                                                isSelected: selectedOptionIndex == optionIndex, // Highlight selected answer
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // GridView.builder(
                              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2, // 2 options per row
                              //     mainAxisSpacing: SizeConstant.spaceMedium,
                              //     crossAxisSpacing: SizeConstant.spaceMedium,
                              //     childAspectRatio: 0.87,
                              //   ),
                              //   shrinkWrap: true,
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   itemCount: question.options.length,
                              //   itemBuilder: (context, optionIndex) {
                              //     var option = question.options[optionIndex];

                              //     return GestureDetector(
                              //       onTap: () {
                              //         discoverProvider.selectAnswer(question.questionId, optionIndex); // Store selected answer by questionId
                              //       },
                              //       child: QandOptCard(
                              //         title: option.answerText,
                              //         //imageUrl: option.answerImageUrl,
                              //         isQuestion: false,
                              //         isSelected: selectedOptionIndex == optionIndex, // Highlight selected answer
                              //       ),
                              //     );
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Check Button (activated when an option is selected)
                Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(
                    left: SizeConstant.appHorizontalPadding,
                    right: SizeConstant.appHorizontalPadding,
                    bottom: SizeConstant.appVerticalPadding,
                  ),
                  child: CommonButton(
                    type: ButtonType.primary,
                    label: context.lang.check,
                    isEnabled: discoverProvider.getSelectedAnswer(currentQuestion.questionId) != -1, // Enable only when an option is selected
                    onPressed: () {
                      int selectedOptionIndex = discoverProvider.getSelectedAnswer(currentQuestion.questionId);
                      if (selectedOptionIndex != -1) {
                        bool isCorrect = currentQuestion.options[selectedOptionIndex].isCorrect;

                        if(isCorrect){
                          discoverProvider.incrementCorrectAnswers();
                          // Show a dialog or toast to inform the user about correctness
                          ParentBottomSheet.show(
                            context, 
                            isDismissible: false,
                            child: CorrectQuizBottomSheet(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Then move to the next question if available
                                if (discoverProvider.currentQuestionIndex < totalQuestions - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                  discoverProvider.nextQuestion();
                                } else {
                                  // Handle end of quiz logic (e.g., show a result screen)
                                  ParentBottomSheet.show(
                                    isDismissible: false,
                                    context, 
                                    child: CompleteQuizBottomSheet(
                                      correctAnswers: discoverProvider.correctAnsCount,
                                      incorrectAnswers: discoverProvider.incorrectAnsCount,
                                      quizTitle: discoverProvider.quizList[0].title,
                                      onPressedFished: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      onPressedNextCourse: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }else{
                          discoverProvider.decrementCorrectAnswers();
                          ParentBottomSheet.show(
                            context, 
                            isDismissible: false,
                            child: IncorrectQuizBottomSheet(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Then move to the next question if available
                              if (discoverProvider.currentQuestionIndex < totalQuestions - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                );
                                discoverProvider.nextQuestion();
                              } else {
                                ParentBottomSheet.show(
                                  isDismissible: false,
                                  context, 
                                  child: CompleteQuizBottomSheet(
                                    correctAnswers: discoverProvider.correctAnsCount,
                                    incorrectAnswers: discoverProvider.incorrectAnsCount,
                                    quizTitle: discoverProvider.quizList[0].title,
                                    onPressedFished: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    onPressedNextCourse: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                              }
                            },
                          ),);
                        }
                      }
                    },
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
