import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_radio_button.dart';
import 'package:mybtccanvas/core/providers/language/language_provider.dart';
import 'package:mybtccanvas/core/providers/preferred_exchange/preferred_exchange_prodiver.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class PreferredExchangeScreen extends StatelessWidget {
  const PreferredExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<LanguageProvider, ThemeProvider>(
          builder: (context, languageProvider, themeProvider, _) {
            return Column(
              children: [
                CustomAppBar(
                  title: context.lang.preferred_exchange,
                ),
                SizedBox(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
                      child: Column(
                        children: [
                          // Accessing the PreferredExchangeProvider
                          Consumer<PreferredExchangeProvider>(
                            builder: (context, exchangeProvider, _) {
                              return Column(
                                children: [
                                  // Binance Radio Button
                                  CustomRadioButton(
                                    title: context.lang.binance,
                                    isSelected: exchangeProvider.selectedCurrency == 'Binance',
                                    onChanged: (value) {
                                      exchangeProvider.selectCurrency('Binance');
                                    },
                                    trailingIcon: Text(
                                      context.lang.by_default,
                                      style: AppTextStyles.urbanistR14(color: themeProvider.currentTheme.appDarkGreenColor),
                                    ),
                                  ),
                                  const SizedBox(height: SizeConstant.spaceLarge),

                                  // Coinbase Radio Button
                                  CustomRadioButton(
                                    title: context.lang.coinbase,
                                    isSelected: exchangeProvider.selectedCurrency == 'Coinbase',
                                    onChanged: (value) {
                                      exchangeProvider.selectCurrency('Coinbase');
                                    },
                                  ),
                                  const SizedBox(height: SizeConstant.spaceLarge),

                                  // Kraken Radio Button
                                  CustomRadioButton(
                                    title: context.lang.kraken,
                                    isSelected: exchangeProvider.selectedCurrency == 'Kraken',
                                    onChanged: (value) {
                                      exchangeProvider.selectCurrency('Kraken');
                                    },
                                  ),
                                  const SizedBox(height: SizeConstant.spaceLarge),
                                ],
                              );
                            },
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
