import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/models/chart/sample_data.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/plan_providerd.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/profile_setup_flow_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/filter_drop_down_menu_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SelectThemeScreen extends StatefulWidget {
  const SelectThemeScreen({super.key});

  @override
  State<SelectThemeScreen> createState() => _SelectThemeScreenState();
}

class _SelectThemeScreenState extends State<SelectThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer3<ThemeProvider, PlanProvider, ProfileSetupFlowProvider>(
        builder: (context, themeProvider, planProvider, profileSetupFlowProvider, _) {
          final Color textColor = themeProvider.currentTheme.textPrimaryColor;
          final Color greyColor = themeProvider.currentTheme.appDarkGreyColor;
          final chartData = profileSetupFlowProvider.chartData;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConstant.appHorizontalPadding,
                vertical: SizeConstant.appVerticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.lang.select_theme,
                    style: AppTextStyles.outfitSB40(color: textColor),
                  ),
                  const SizedBox(height: SizeConstant.spaceSmall),
                  Text(
                    context.lang.select_theme_description,
                    style: AppTextStyles.outfitR16(color: greyColor),
                  ),
                  const SizedBox(height: SizeConstant.spaceMedium),

                  // Theme selection container
                  _buildThemeSelection(themeProvider, profileSetupFlowProvider),

                  const SizedBox(height: SizeConstant.spaceMedium),
                  // Graph Card
                  _buildGraphCard(chartData, themeProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Theme selection container
  Widget _buildThemeSelection(themeProvider, profileSetupFlowProvider) {
    final backgroundColor = themeProvider.currentTheme.appSecondaryColor;
    final unselectedTextColor = themeProvider.currentTheme.textSecondaryColor;
    final selectedColor = themeProvider.currentTheme.appPrimaryColor;
    final borderColor = themeProvider.currentTheme.borderColor;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [context.lang.dark, context.lang.light].map((theme) {
            final bool isSelected = (theme == context.lang.dark && themeProvider.isDarkMode) ||
                (theme == context.lang.light && !themeProvider.isDarkMode);

            return GestureDetector(
              onTap: () {
                // Toggle the theme based on selection
                if (theme == context.lang.dark) {
                  themeProvider.switchTheme(
                    isSystemTheme: false,
                    isDarkMode: true,
                  );
                } else {
                  themeProvider.switchTheme(
                    isSystemTheme: false,
                    isDarkMode: false,
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 20,
                padding: const EdgeInsets.symmetric(
                    vertical: SizeConstant.paddingSmall, horizontal: SizeConstant.paddingMedium),
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    theme,
                    style: TextStyle(
                      color: isSelected ? Colors.black : unselectedTextColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Graph Card
  Widget _buildGraphCard(chartData, themeProvider) {
    final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
    final Color textColor = themeProvider.currentTheme.textPrimaryColor;
    final Color selectedIconColor = themeProvider.currentTheme.appThirdColor;
    final Color unSelectedIconColor = themeProvider.currentTheme.textPrimaryColor;
    final Color borderColor = themeProvider.currentTheme.borderColor;
    final Color decrementColor = themeProvider.currentTheme.appRedColor;
    final Color iconColor = themeProvider.currentTheme.textPrimaryColor;
    final Color whiteColor = themeProvider.currentTheme.appWhiteColor;
    return Stack(
      children: [
        // Main container
        Container(
          height: 250,
          padding: const EdgeInsets.all(SizeConstant.paddingSmall),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bitcoin Price',
                    style: AppTextStyles.urbanistR14(color: textColor),
                  ),
                  Row(
                    children: [
                      IgnorePointer(
                        ignoring: true,
                        child: SizedBox(
                          width: 90,
                          child: FilterDropDownMenuButton(
                            label: 'Week',
                            onPressed: () {},
                          ),
                        ),
                      ),
                      const SizedBox(width: SizeConstant.spaceSmall),
                      // info icon
                      SvgPicture.asset(
                        AppAssets.infoIcon,
                        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "\$34,000",
                    style: AppTextStyles.outfitSB40(color: textColor),
                  ),
                  const SizedBox(width: SizeConstant.spaceSmall),
                  Transform.translate(
                    offset: const Offset(0, -25),
                    child: Row(
                      children: [
                        Text(
                          "+5.12%",
                          style: AppTextStyles.outfitM14(color: decrementColor),
                        ),
                        Icon(
                          Icons.arrow_downward,
                          color: decrementColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Candlestick chart
              Expanded(
                  child: SizedBox(
                height: 400,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: const DateTimeAxis(
                    isVisible: false,
                    intervalType: DateTimeIntervalType.days,
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: false, // Show the Y axis for reference
                    minimum: chartData.map((data) => data.low).reduce((a, b) => a < b ? a : b),
                    maximum: chartData.map((data) => data.high).reduce((a, b) => a > b ? a : b),
                  ),
                  series: <CandleSeries<ChartSampleData, DateTime>>[
                    CandleSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      lowValueMapper: (ChartSampleData sales, _) => sales.low,
                      highValueMapper: (ChartSampleData sales, _) => sales.high,
                      openValueMapper: (ChartSampleData sales, _) => sales.open,
                      closeValueMapper: (ChartSampleData sales, _) => sales.close,
                      borderWidth: 1.0,
                      width: 0.6,
                      enableSolidCandles: true,
                      animationDuration: 0,
                    )
                  ],
                ),
              )),
            ],
          ),
        ),

        // Chart selection icons
        Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              height: 40,
              width: 84,
              decoration: BoxDecoration(
                color: whiteColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusSmall),
              ),
              child: Padding(
                padding: const EdgeInsets.all(SizeConstant.paddingExtraSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    {
                      'iconPath': AppAssets.lineChartIcon,
                      'isSelected': true,
                    },
                    {
                      'iconPath': AppAssets.barChartIcon,
                      'isSelected': false,
                    },
                  ].map((item) {
                    final String iconPath = item['iconPath'] as String;
                    final bool isSelected = item['isSelected'] as bool;

                    return Container(
                      padding: const EdgeInsets.all(SizeConstant.paddingExtraSmall),
                      decoration: BoxDecoration(
                        color: isSelected ? whiteColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusSmall),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          iconPath,
                          width: SizeConstant.iconSizeMedium,
                          height: SizeConstant.iconSizeMedium,
                          colorFilter: ColorFilter.mode(
                              isSelected ? selectedIconColor : unSelectedIconColor, BlendMode.srcIn),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ))
      ],
    );
  }
}
