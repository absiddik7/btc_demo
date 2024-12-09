import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/currency/currency_provider.dart';
import 'package:mybtccanvas/core/providers/language/language_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_radio_button.dart';
import 'package:provider/provider.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer2<LanguageProvider, ThemeProvider>(
          builder: (context, languageProvider, themeProvider, _) {
            return Column(
              children: [
                CustomAppBar(
                  title: context.lang.currency,
                ),
                SizedBox(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeConstant.appHorizontalPadding, vertical: SizeConstant.appVerticalPadding),
                      child: Column(
                        children: [
                          // Accessing the CurrencyProvider
                          Consumer<CurrencyProvider>(
                            builder: (context, currencyProvider, _) {
                              return Column(
                                children: [
                                  // Binance Radio Button
                                  CustomRadioButton(
                                    title: context.lang.binance,
                                    isSelected: currencyProvider.selectedCurrency == 'Binance',
                                    onChanged: (value) {
                                      currencyProvider.selectCurrency('Binance');
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
                                    isSelected: currencyProvider.selectedCurrency == 'Coinbase',
                                    onChanged: (value) {
                                      currencyProvider.selectCurrency('Coinbase');
                                    },
                                  ),
                                  const SizedBox(height: SizeConstant.spaceLarge),

                                  // Kraken Radio Button
                                  CustomRadioButton(
                                    title: context.lang.coinbase,
                                    isSelected: currencyProvider.selectedCurrency == 'Kraken',
                                    onChanged: (value) {
                                      currencyProvider.selectCurrency('Kraken');
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
