import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color secondaryTextColor = themeProvider.currentTheme.textSecondaryColor;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.celebrateImg,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: SizeConstant.spaceLarge),
                  // Title text
                  Text(
                    context.lang.thanks_for_joining_us,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.outfitSB32(color: textColor),
                  ),
                  const SizedBox(height: SizeConstant.spaceSmall),
                  // Description text
                  Text(
                    context.lang.thanks_for_joining_us_description,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.outfitR16(color: secondaryTextColor),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
