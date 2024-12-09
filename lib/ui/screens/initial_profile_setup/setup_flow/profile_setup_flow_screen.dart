import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/discover/discover_provider.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/plan_providerd.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/profile_setup_flow_provider.dart';
import 'package:mybtccanvas/core/providers/personal_info/personal_info_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/bordered_circular_progress.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class ProfileSetupFlowScreen extends StatefulWidget {
  const ProfileSetupFlowScreen({super.key});

  @override
  State<ProfileSetupFlowScreen> createState() => _ProfileSetupFlowScreenState();
}

class _ProfileSetupFlowScreenState extends State<ProfileSetupFlowScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  double iconSize = SizeConstant.iconSizeLarge - 2;
  double totalStrokeWidth = 5.0;
  double borderStrokeWidth = 0.5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiscoverProvider>(context, listen: false).resetQuiz();
      Provider.of<ProfileSetupFlowProvider>(context, listen: false).resetFlow();
      _pageController.jumpToPage(0); // Reset to the first page
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer4<ThemeProvider, ProfileSetupFlowProvider, PersonalInfoProvider, PlanProvider>(
          builder: (context, themeProvider, profileSetupFlowProvider, personalInfoProvider, planProvider, _) {
            int currentScreenIndex = profileSetupFlowProvider.currentScreenIndex;
            int totalScreens = profileSetupFlowProvider.totalScreens;
            double progress = profileSetupFlowProvider.progress;
            List screens = profileSetupFlowProvider.screens;
            final Color progressColor = themeProvider.currentTheme.highlightTextColor;

            return Column(
              children: [
                // Custom App Bar with progress indicator
                CustomAppBar(
                  title: '',
                  onBackButtonPressed: () {
                    if (currentScreenIndex == 0) {
                      // If on the first screen, pop the current navigation stack
                      Navigator.pop(context);
                    } else {
                      // If on any other screen, go to the previous page
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  trailingIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${currentScreenIndex + 1}/$totalScreens',
                        style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                      ),
                      const SizedBox(width: SizeConstant.spaceSmall),
                      BorderedCircularProgress(
                        iconSize: iconSize,
                        progress: progress,
                        totalStrokeWidth: totalStrokeWidth,
                        borderStrokeWidth: borderStrokeWidth,
                        progressColor: progressColor,
                        backgroundColor: themeProvider.isDarkMode
                            ? themeProvider.currentTheme.appSecondaryColor
                            : themeProvider.currentTheme.textSecondaryColor,
                        borderColor: themeProvider.isDarkMode
                            ? themeProvider.currentTheme.borderColor
                            : themeProvider.currentTheme.appGreyColor,
                      ),
                      const SizedBox(width: SizeConstant.spaceSmall),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: screens.length,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      profileSetupFlowProvider.setCurrentScreenIndex(index);
                    },
                    itemBuilder: (context, index) {
                      return screens[index];
                    },
                  ),
                ),

                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: _buildBottomButtons(
                        context, profileSetupFlowProvider, personalInfoProvider, planProvider),
                  ),
                ),
                const SizedBox(height: SizeConstant.spaceMedium),
              ],
            );
          },
        ),
      ),
    );
  }

  // handle button building based on conditions
  Widget _buildBottomButtons(BuildContext context, ProfileSetupFlowProvider profileSetupFlowProvider,
      PersonalInfoProvider personalInfoProvider, PlanProvider planProvider) {
    final isAvatarUploaded = personalInfoProvider.selectedImage;
    final currentScreenIndex = profileSetupFlowProvider.currentScreenIndex;
    final totalScreens = profileSetupFlowProvider.screens.length;
    final isLastScreen = currentScreenIndex == totalScreens - 1;

    // Check if the current screen is the avatar selection screen
    if (currentScreenIndex == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CommonButton(
              type: ButtonType.secondary,
              label: context.lang.skip,
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CommonButton(
              type: ButtonType.primary,
              label: isAvatarUploaded != null ? context.lang.upload : context.lang.next,
              onPressed: () {
                if (isAvatarUploaded != null) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
            ),
          ),
        ],
      );
    } else {
      return CommonButton(
        type: ButtonType.primary,
        label: isLastScreen
            ? context.lang.lets_go
            : (isAvatarUploaded != null && currentScreenIndex == 3 ? context.lang.upload : context.lang.next),
        isEnabled:
            profileSetupFlowProvider.isDescriptionSelected && profileSetupFlowProvider.isInterestSelected,
        onPressed: () {
          if (isLastScreen) {
            // Final action for profile setup
          } else {
            // check if the current screen is in index 1
            if (currentScreenIndex == 1) {
              // check if the selected plan is not empty
              if (planProvider.selectedPlan != '') {
                String currentPlan = planProvider.selectedPlan;
                print('Selected Plan: $currentPlan');
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }

            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
      );
    }
  }
}
