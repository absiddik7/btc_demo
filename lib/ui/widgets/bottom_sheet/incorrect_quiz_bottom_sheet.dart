import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:provider/provider.dart';

class IncorrectQuizBottomSheet extends StatelessWidget {
  final VoidCallback onPressed;
  const IncorrectQuizBottomSheet({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Image.asset(
                AppAssets.incorrectQuizImg,
                width: 86,
                height: 72,
              ),
              Text('Incorrect', style: AppTextStyles.outfitSB40(color: textColor)),
              const SizedBox(height: 16),
              CommonButton(type: ButtonType.primary, label: "Got it", onPressed: onPressed),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
