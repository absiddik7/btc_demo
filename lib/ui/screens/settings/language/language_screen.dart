import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/language/language_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_radio_button.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<LanguageProvider, ThemeProvider>(
          builder: (context, languageProvider, themeProvider, _) {
            return Column(
              children: [
                CustomAppBar(
                  title: context.lang.language
                ),
                SizedBox(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
                      child: Column(
                        children: [
                          // English Radio Button
                          _buildRadioButtons(
                              context, context.lang.english, languageProvider, 'en', AppAssets.engLangFlagImg),

                          // German Radio Button
                          _buildRadioButtons(
                              context, context.lang.german, languageProvider, 'de', AppAssets.germanLangFlagImg),

                          // Italian Radio Button
                          _buildRadioButtons(
                              context, context.lang.italian, languageProvider, 'it', AppAssets.italianLangFlagImg),

                          // Spanish Radio Button
                          _buildRadioButtons(
                              context, context.lang.spanish, languageProvider, 'es', AppAssets.spenishLangFlagImg),
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

  Widget _buildRadioButtons(
      BuildContext context, String title, LanguageProvider languageProvider, String lang, String flag) {
    return Column(
      children: [
        CustomRadioButton(
          title: title,
          isSelected: languageProvider.appLocale == Locale(lang),
          onChanged: (value) {
            languageProvider.changeLanguage(Locale(lang));
          },
          trailingIcon: Image.asset(
            flag,
            fit: BoxFit.cover,
            width: SizeConstant.iconSizeMedium,
            height: SizeConstant.iconSizeExtraSmall+2,
          ),
        ),
        const SizedBox(height: SizeConstant.spaceLarge),
      ],
    );
  }
}
