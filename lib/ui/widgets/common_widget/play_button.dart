import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatefulWidget {
  final double iconSize;
  const PlayButton({super.key, required this.iconSize});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: themeProvider.currentTheme.appSecondaryColor,
              shape: BoxShape.circle,
              border: themeProvider.isDarkMode? null : Border.all(
                color: themeProvider.currentTheme.borderColor,
                width: SizeConstant.borderWidthSmall
              )
            ),
            child: Container(
              width: widget.iconSize,
              height: widget.iconSize,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAssets.playIcon,
                width: widget.iconSize,
                height: widget.iconSize,
                colorFilter: ColorFilter.mode(themeProvider.currentTheme.videoCardPlayIconColor, BlendMode.srcIn),
              ),
            ),
          );
        },
      )
    );
  }
}