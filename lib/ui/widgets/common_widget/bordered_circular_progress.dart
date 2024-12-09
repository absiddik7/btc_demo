import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class BorderedCircularProgress extends StatefulWidget {
  final double iconSize;
  final double progress;
  final double totalStrokeWidth;
  final double borderStrokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Color borderColor;

  const BorderedCircularProgress({
    super.key, 
    required this.iconSize, 
    required this.progress, 
    required this.totalStrokeWidth, 
    required this.borderStrokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderColor
  });

  @override
  State<BorderedCircularProgress> createState() => _BorderedCircularProgressState();
}

class _BorderedCircularProgressState extends State<BorderedCircularProgress> {
  @override
  Widget build(BuildContext context) {
    final double iconSize = widget.iconSize;
    final double progress = widget.progress;
    final double totalStrokeWidth = widget.totalStrokeWidth;
    final double borderStrokeWidth = widget.borderStrokeWidth;
    final Color backgroundColor = widget.backgroundColor;
    final Color progressColor = widget.progressColor;
    final Color borderColor = widget.borderColor;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          width: iconSize,
          height: iconSize,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background Circle (for the border part)
              Container(
                width: iconSize,
                height: iconSize,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: 1.0, // Always full
                  strokeWidth: totalStrokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(borderColor),
                ),
              ),
        
              // Background filling Circle
              Container(
                width: iconSize - borderStrokeWidth * 2,
                height: iconSize- borderStrokeWidth * 2,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: 1.0, // Always full
                  strokeWidth: totalStrokeWidth - borderStrokeWidth * 2,
                  valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
                ),
              ),
          
              // Foreground Circle (for the progress part)
              Container(
                width: iconSize,
                height: iconSize,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: progress, // Dynamic progress
                  strokeWidth: totalStrokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  backgroundColor: Colors.transparent,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ],
          ),
        );
      }
    );
    
    // return Consumer<ThemeProvider>(
    //   builder: (context, themeProvider, _) {
    //     return Container(
    //       width: iconSize,
    //       height: iconSize,
    //       alignment: Alignment.center,
    //       color: Colors.transparent,
    //       child: Stack(
    //         alignment: Alignment.center,
    //         children: [
    //           // Background Circle (for the border part)
    //           Container(
    //             width: iconSize + totalStrokeWidth - borderStrokeWidth * 2,
    //             height: iconSize + totalStrokeWidth - borderStrokeWidth * 2,
    //             alignment: Alignment.center,
    //             child: CircularProgressIndicator(
    //               value: 1.0, // Always full
    //               strokeWidth: borderStrokeWidth,
    //               //valueColor: AlwaysStoppedAnimation<Color>(themeProvider.isDarkMode? themeProvider.currentTheme.borderColor : themeProvider.currentTheme.appGreyColor),
    //               valueColor: AlwaysStoppedAnimation<Color>(borderColor),
    //             ),
    //           ),
        
    //           // Background filling Circle
    //           Container(
    //             width: iconSize,
    //             height: iconSize,
    //             alignment: Alignment.center,
    //             child: CircularProgressIndicator(
    //               value: 1.0, // Always full
    //               strokeWidth: totalStrokeWidth - borderStrokeWidth * 2,
    //               //valueColor: AlwaysStoppedAnimation<Color>(themeProvider.isDarkMode? themeProvider.currentTheme.appSecondaryColor : themeProvider.currentTheme.textSecondaryColor),
    //               valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
    //             ),
    //           ),
        
    //           // Background Circle (for the border part)
    //           Container(
    //             width: iconSize - (totalStrokeWidth - borderStrokeWidth * 2),
    //             height: iconSize - (totalStrokeWidth - borderStrokeWidth * 2),
    //             alignment: Alignment.center,
    //             child: CircularProgressIndicator(
    //               value: 1.0, // Always full
    //               strokeWidth: borderStrokeWidth,
    //               //valueColor: AlwaysStoppedAnimation<Color>(themeProvider.isDarkMode? themeProvider.currentTheme.borderColor : themeProvider.currentTheme.appGreyColor), 
    //               valueColor: AlwaysStoppedAnimation<Color>(borderColor), 
    //             ),
    //           ),
          
    //           // Foreground Circle (for the progress part)
    //           Container(
    //             width: iconSize,
    //             height: iconSize,
    //             alignment: Alignment.center,
    //             child: CircularProgressIndicator(
    //               value: progress, // Dynamic progress
    //               strokeWidth: totalStrokeWidth,
    //               //valueColor: AlwaysStoppedAnimation<Color>(themeProvider.currentTheme.appPrimaryColor),
    //               valueColor: AlwaysStoppedAnimation<Color>(progressColor),
    //               backgroundColor: Colors.transparent,
    //               strokeCap: StrokeCap.round,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // );
  }
}