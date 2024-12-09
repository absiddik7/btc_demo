import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/models/subscription/plan_model.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/plan_providerd.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/profile_setup_flow_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class SelectPlanScreen extends StatelessWidget {
  // check if this ui is for initial setup
  final bool isInitialSetup;
  const SelectPlanScreen({super.key, this.isInitialSetup = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer3<ThemeProvider, PlanProvider, ProfileSetupFlowProvider>(
        builder: (context, themeProvider, planProvider, profileSetupFlowProvider, _) {
          final Color textColor = themeProvider.currentTheme.textPrimaryColor;
          final Color greyColor = themeProvider.currentTheme.appDarkGreyColor;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isInitialSetup,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.lang.select_plan,
                          style: AppTextStyles.outfitSB40(color: textColor),
                        ),
                        const SizedBox(height: SizeConstant.spaceSmall),
                        Text(
                          context.lang.select_plan_description,
                          style: AppTextStyles.outfitR16(color: greyColor),
                        ),
                        const SizedBox(height: SizeConstant.spaceMedium),
                      ],
                    ),
                  ),
                  _buildFeatureTable(planProvider, context),
                  const SizedBox(height: SizeConstant.spaceLarge),
                  _buildPlanOptions(context, planProvider, profileSetupFlowProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // build the feature table
  Widget _buildFeatureTable(PlanProvider planProvider, context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
    final Color borderColor = themeProvider.currentTheme.borderColor;
    final Color selectedBorderColor = themeProvider.currentTheme.highlightTextColor;

    bool isProSelected = planProvider.selectedTier == 'Pro';
    bool isFreeSelected = planProvider.selectedTier == 'Free';
    Plan selectedPlanDetails = planProvider.selectedPlanDetails;

    // Calculate column widths
    final double columnWidth = (MediaQuery.of(context).size.width - 64) / 3;

    return Stack(
      children: [
        // Main content container
        Container(
          padding: const EdgeInsets.all(SizeConstant.paddingMedium),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
            color: backgroundColor,
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Features Header
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Features",
                        style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: SizeConstant.spaceSmall),
                  // Free Header
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Free",
                        style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: SizeConstant.spaceSmall),
                  // Pro Header
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Pro",
                        style: AppTextStyles.outfitSB16(color: themeProvider.currentTheme.textPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SizeConstant.spaceMedium),
              for (var feature in selectedPlanDetails.features) ...[
                _buildFeatureRowWithPlans(context, feature.name, feature.free, feature.pro),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),

        // Clickable areas for Free and Pro columns
        Positioned.fill(
          child: Row(
            children: [
              // Features column - not clickable
              SizedBox(width: columnWidth + 16), // accounting for padding

              // Free column clickable area
              Expanded(
                child: GestureDetector(
                  onTap: () => planProvider.selectTier('Free'),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),

              // Pro column clickable area
              Expanded(
                child: GestureDetector(
                  onTap: () => planProvider.selectTier('Pro'),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Selection borders
        if (isFreeSelected)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: columnWidth,
                margin: const EdgeInsets.only(
                    top: SizeConstant.marginSmall,
                    bottom: SizeConstant.marginSmall,
                    left: SizeConstant.marginSmall),
                decoration: BoxDecoration(
                  border: Border.all(color: selectedBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                ),
              ),
            ),
          ),
        if (isProSelected)
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: columnWidth,
                margin: const EdgeInsets.only(
                    top: SizeConstant.marginSmall, bottom: SizeConstant.marginSmall, right: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: selectedBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // build the row for each feature
  Widget _buildFeatureRowWithPlans(context, String feature, String freeFeature, String proFeature) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final Color textColor = themeProvider.currentTheme.textPrimaryColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Feature name
        Expanded(
          child: Center(
            child: Text(
              feature,
              style: AppTextStyles.outfitR16(color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: SizeConstant.spaceSmall),
        // Free plan description
        Expanded(
          child: Center(
            child: freeFeature.toLowerCase() == 'no'
                ? SvgPicture.asset(AppAssets.closeIcon,
                    height: SizeConstant.iconSizeSmall, width: SizeConstant.iconSizeSmall)
                : freeFeature.toLowerCase() == 'yes'
                    ? SvgPicture.asset(AppAssets.doneIcon,
                        height: SizeConstant.iconSizeSmall, width: SizeConstant.iconSizeSmall)
                    : Text(
                        freeFeature,
                        style: AppTextStyles.outfitR16(color: textColor),
                        textAlign: TextAlign.center,
                      ),
          ),
        ),
        const SizedBox(width: 8),
        // Pro plan description
        Expanded(
          child: Center(
            child: proFeature.toLowerCase() == 'no'
                ? SvgPicture.asset(AppAssets.closeIcon,
                    height: SizeConstant.iconSizeSmall, width: SizeConstant.iconSizeSmall)
                : proFeature.toLowerCase() == 'yes'
                    ? SvgPicture.asset(AppAssets.doneIcon,
                        height: SizeConstant.iconSizeSmall, width: SizeConstant.iconSizeSmall)
                    : Text(
                        proFeature,
                        style: AppTextStyles.outfitR16(color: textColor),
                        textAlign: TextAlign.center,
                      ),
          ),
        ),
      ],
    );
  }

// build the plan options
  Widget _buildPlanOptions(
      BuildContext context, PlanProvider planProvider, ProfileSetupFlowProvider profileSetupFlowProvider) {
    return Column(
      children: planProvider.plans.map((plan) {
        return _buildPlanOption(
          context,
          planProvider,
          plan.name,
          plan.pricing,
          plan.badge,
          profileSetupFlowProvider,
        );
      }).toList(),
    );
  }

  // build the plan option
  Widget _buildPlanOption(
    BuildContext context,
    PlanProvider planProvider,
    String planType,
    String pricing,
    String badge,
    ProfileSetupFlowProvider profileSetupFlowProvider,
  ) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final Color textColor = themeProvider.currentTheme.textPrimaryColor;
    final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
    final Color appThirdColor = themeProvider.currentTheme.appThirdColor;
    final Color secondaryTextColor = themeProvider.currentTheme.textSecondaryColor;
    final Color borderColor = themeProvider.currentTheme.borderColor;
    final radioFillColor = themeProvider.currentTheme.highlightTextColor;
    final unselectedBorderColor = themeProvider.currentTheme.borderColor;

    return GestureDetector(
      onTap: () {
        // Change the selected plan when the container is tapped
        planProvider.selectPlan(planType);
        profileSetupFlowProvider.selectPlan(planType);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: SizeConstant.marginMedium),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
        ),
        child: ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: CupertinoRadio<String>(
              value: planType,
              groupValue: planProvider.selectedPlan,
              onChanged: (String? value) {
                if (value != null) {
                  planProvider.selectPlan(value);
                  profileSetupFlowProvider.selectPlan(value);
                }
              },
              fillColor: radioFillColor,
              activeColor: unselectedBorderColor,
              inactiveColor: unselectedBorderColor,
            ),
          ),
          title: Row(
            children: [
              Text(
                planType,
                style: AppTextStyles.outfitSB16(color: textColor),
              ),
              if (badge.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: SizeConstant.marginSmall),
                  padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstant.paddingSmall, vertical: SizeConstant.paddingExtraSmall),
                  decoration: BoxDecoration(
                    color: appThirdColor,
                    borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusExtraSmall),
                  ),
                  child: Text(
                    badge,
                    style: AppTextStyles.urbanistB14(color: Colors.white),
                  ),
                ),
            ],
          ),
          subtitle: Text(pricing, style: AppTextStyles.outfitR16(color: secondaryTextColor)),
        ),
      ),
    );
  }
}
