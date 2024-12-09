import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/language/language_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_radio_button.dart';
import 'package:provider/provider.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.checkSystemTheme();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<LanguageProvider, ThemeProvider>(
          builder: (context, languageProvider, themeProvider, _) {
            final iconColor = themeProvider.currentTheme.appThirdColor;

            return Column(
              children: [
                CustomAppBar(
                  title: context.lang.appearance,
                ),
                SizedBox(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
                      child: Column(
                        children: [
                          // Light Mode Radio Button
                          CustomRadioButton(
                            title: context.lang.light_mode,
                            isSelected: !themeProvider.useSystemTheme && !themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.switchTheme(isSystemTheme: false, isDarkMode: false);
                            },
                            trailingIcon: SvgPicture.asset(
                              AppAssets.lightThemeIcon,
                              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                            ),
                          ),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // Dark Mode Radio Button
                          CustomRadioButton(
                            title: context.lang.dark_mode,
                            isSelected: !themeProvider.useSystemTheme && themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.switchTheme(isSystemTheme: false, isDarkMode: true);
                            },
                            trailingIcon: SvgPicture.asset(
                              AppAssets.appearanceIcon,
                              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                            ),
                          ),
                          const SizedBox(height: SizeConstant.spaceLarge),

                          // System Settings Radio Button
                          CustomRadioButton(
                            title: context.lang.system_settings,
                            isSelected: themeProvider.useSystemTheme,
                            onChanged: (value) {
                              themeProvider.switchTheme(isSystemTheme: true);
                            },
                            trailingIcon: SvgPicture.asset(
                              AppAssets.systemThemeIcon,
                              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                            ),
                          ),
                          const SizedBox(height: SizeConstant.spaceLarge),
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
