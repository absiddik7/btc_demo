import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomBackground extends StatefulWidget {
  final Widget child;

  const CustomBackground({
    super.key,
    required this.child,
  });

  @override
  State<CustomBackground> createState() => _CustomBackgroundState();
}

class _CustomBackgroundState extends State<CustomBackground> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Calculate sizes and positions relative to the screen size
    final double circleSize = size.shortestSide * 1.3;
    final double ellipseWidth1 = size.shortestSide * 1.0;
    final double ellipseHeight1 = size.shortestSide * 0.55;
    const double ellipseRotationAngle1 = 149.13; // Defined rotation angle for ellipse 1

    final double ellipseWidth2 = size.shortestSide * 0.6;
    final double ellipseHeight2 = size.shortestSide * 0.3;
    const double ellipseRotationAngle2 = 90.0; // Defined rotation angle for ellipse 2
    final double ellipse2Top = size.height * 0.25;
    final double ellipse2Left = size.width * 0.75;

    // New ellipse properties
    final double ellipseWidth3 = size.shortestSide * 0.001;
    final double ellipseHeight3 = size.shortestSide * 0.001;
    const double ellipseRotationAngle3 = 30.0; // Defined rotation angle for ellipse 3
    final double ellipse3Top = size.height * 0.01;
    final double ellipse3Left = size.width * 0.01;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Stack(
          children: [
            Container(
              color: themeProvider.currentTheme.mainBackgroundPrimaryColor
            ),

            themeProvider.isDarkMode?
            Positioned(
              top: size.height * 0.7,
              left: size.width * -0.2,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF2F2B81).withOpacity(0.09),
                        const Color(0xFFA0A6F9).withOpacity(0.09),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ) : Container(),

            themeProvider.isDarkMode?
            Positioned(
              top: size.height * -0.1,
              left: size.width * -0.15,
              child: Transform.rotate(
                angle: ellipseRotationAngle1 *
                    (3.141592653589793 / 180.0), // Convert degrees to radians
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                  child: Container(
                    width: ellipseWidth1,
                    height: ellipseHeight1,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(ellipseWidth1 / 2, ellipseHeight1 / 2),
                      ),
                      color: const Color(0xFF6F85FE).withOpacity(0.08),
                    ),
                  ),
                ),
              ),
            ) : Container(),

            themeProvider.isDarkMode?
            Positioned(
              top: ellipse2Top,
              left: ellipse2Left,
              child: Transform.rotate(
                angle: ellipseRotationAngle2 *
                    (3.141592653589793 / 180.0), // Convert degrees to radians
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(
                    width: ellipseWidth2,
                    height: ellipseHeight2,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(ellipseWidth2 / 2, ellipseHeight2 / 2),
                      ),
                      color: const Color(0xFFA0A6F9).withOpacity(0.08),
                    ),
                  ),
                ),
              ),
            ) : Container(),

            themeProvider.isDarkMode?
            Positioned(
              top: ellipse3Top,
              left: ellipse3Left,
              child: Transform.rotate(
                angle: ellipseRotationAngle3 *
                    (3.141592653589793 / 180.0), // Convert degrees to radians
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                  child: Container(
                    width: ellipseWidth3,
                    height: ellipseHeight3,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(ellipseWidth3 / 2, ellipseHeight3 / 2),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ) : Container(),
            widget.child,
          ],
        );
      },
    );
  }
}