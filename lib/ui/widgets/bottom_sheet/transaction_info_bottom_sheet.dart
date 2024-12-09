import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class TransactionInfoBottomSheet extends StatelessWidget {
  const TransactionInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color iconColor =
            themeProvider.currentTheme.transactionInfoIconColor;
        const String amountTransaction = '+0.00250 BTC';
        const String amountUSD = '+\$150.00';
        const String dateTime = '12.12.2024 10:45AM';
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Transaction Information',
                  style: AppTextStyles.outfitSB24(color: textColor),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppAssets.btcIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Text('Bitcoin',
                  style: AppTextStyles.outfitSB24(color: textColor)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount transaction',
                            style: AppTextStyles.outfitR16(color: textColor)),
                        Text(amountTransaction,
                            style: AppTextStyles.outfitR16(color: textColor)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('USD amount',
                            style: AppTextStyles.outfitR16(color: textColor)),
                        Text(amountUSD,
                            style: AppTextStyles.outfitR16(color: textColor)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date & Time',
                            style: AppTextStyles.outfitR16(color: textColor)),
                        Text(dateTime,
                            style: AppTextStyles.outfitR16(color: textColor)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
            ],
          ),
        );
      },
    );
  }
}
