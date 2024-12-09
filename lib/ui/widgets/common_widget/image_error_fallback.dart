import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:provider/provider.dart';

class ImageErrorFallback extends StatelessWidget {
  const ImageErrorFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                themeProvider.currentTheme.imageFallbackGradientOneColor,
                themeProvider.currentTheme.imageFallbackGradientTwoColor,
              ],
            ),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppAssets.imageFallbackIcon,
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(themeProvider.currentTheme.appWhiteColor , BlendMode.srcIn),
          ),
        );
      },
    );
  }
}
