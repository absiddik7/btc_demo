import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/profile_setup_flow_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer2<ThemeProvider, ProfileSetupFlowProvider>(
        builder: (context, themeProvider, profileSetupFlowProvider, _) {
          final Color textColor = themeProvider.currentTheme.textPrimaryColor;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.lang.what_best_describes_you,
                    style: AppTextStyles.outfitSB40(color: textColor),
                  ),
                  const SizedBox(height: SizeConstant.spaceMedium),
                  // What best describes you? options
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: profileSetupFlowProvider.describesOptions.map((option) {
                        return _buildOptionCard(
                          icon: option["icon"]!,
                          label: option["label"]!,
                          themeProvider: themeProvider,
                          isSelected: profileSetupFlowProvider.selectedDescription == option["description"],
                          onTap: () => profileSetupFlowProvider.selectDescription(option["description"]!),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: SizeConstant.spaceLarge),
                  Text(
                    context.lang.what_interests_you_most,
                    style: AppTextStyles.outfitSB40(color: textColor),
                  ),
                  const SizedBox(height: SizeConstant.spaceMedium),
                  // What interests you most? tags
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: profileSetupFlowProvider.interests.map((interest) {
                      return _buildInterestTag(
                        label: interest,
                        themeProvider: themeProvider,
                        isSelected: profileSetupFlowProvider.selectedInterests.contains(interest),
                        onTap: () => profileSetupFlowProvider.toggleInterest(interest),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: SizeConstant.spaceLarge),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // What best describes you? card
  Widget _buildOptionCard({
    required String icon,
    required String label,
    required ThemeProvider themeProvider,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color textColor = themeProvider.currentTheme.textPrimaryColor;
    final Color iconColor = themeProvider.currentTheme.highlightTextColor;
    final Color selectedIconColor = themeProvider.currentTheme.mainBackgroundPrimaryColor;
    final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
    final Color selectedBackgroundColor = themeProvider.currentTheme.highlightTextColor;
    final Color selectedTextColor = themeProvider.currentTheme.mainBackgroundPrimaryColor;
    final Color borderColor = themeProvider.currentTheme.borderColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 108,
        width: 115,
        margin: const EdgeInsets.only(right: SizeConstant.spaceMedium),
        padding: const EdgeInsets.all(SizeConstant.paddingExtraSmall),
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : backgroundColor,
          border: isSelected ? null : Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 44,
                width: 49,
                child: SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(isSelected ? selectedIconColor : iconColor, BlendMode.srcIn),
                ),
              ),
              Center(
                child: Text(
                  label,
                  style: AppTextStyles.outfitR16(color: isSelected ? selectedTextColor : textColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // What interests you most? tags
  Widget _buildInterestTag(
      {required String label,
      required themeProvider,
      required bool isSelected,
      required VoidCallback onTap}) {
    final Color textColor = themeProvider.currentTheme.textPrimaryColor;
    final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
    final Color selectedBackgroundColor = themeProvider.currentTheme.appPrimaryColor;
    final Color selectedTextColor = themeProvider.currentTheme.appBlackColor;
    final Color selectedBorderColor = themeProvider.currentTheme.appPrimaryColor;
    final Color borderColor = themeProvider.currentTheme.borderColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : backgroundColor,
          border: isSelected ? Border.all(color: selectedBorderColor) : Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeConstant.paddingMedium, vertical: SizeConstant.paddingSmall),
          child: Text(
            label,
            style: AppTextStyles.outfitR16(color: isSelected ? selectedTextColor : textColor),
          ),
        ),
      ),
    );
  }
}
