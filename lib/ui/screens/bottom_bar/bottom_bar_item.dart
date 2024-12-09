import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/bottom_bar/bottom_bar_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:provider/provider.dart';

// class BottomBarItem extends StatelessWidget {
//   final String svgImage;
//   final int index;
//   final String label;
//   final bool isActive;
//   final void Function() onTap;
//   final AnimationController animationController;

//   const BottomBarItem({
//     super.key,
//     required this.svgImage,
//     required this.index,
//     required this.label,
//     required this.isActive,
//     required this.onTap,
//     required this.animationController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             svgImage,
//             width: 24,
//             height: 24,
//             // colorFilter: ColorFilter.mode(
//             //   isActive ? Colors.yellow : Colors.white,
//             //   BlendMode.srcIn,
//             // ),

//             colorFilter: const ColorFilter.mode(
//                Colors.white,
//               BlendMode.srcIn,
//             ),
//           ),
//           if (isActive)
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.yellow,
//                 borderRadius: BorderRadius.circular(40),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.yellow.withOpacity(0.3), // Neon glow color
//                     spreadRadius: 16,
//                     blurRadius: 24,
//                     offset: const Offset(0, -8), // Shadow position
//                   ),
//                 ],
//               ),
//               margin: const EdgeInsets.only(top: 4),
//               width: 24,
//               height: 5,
//             ),
//         ],
//       ),
//     );
//   }
// }

class BottomBarItem extends StatelessWidget {
  final String svgImage;
  final int index;
  final String label;
  final AnimationController animationController;

  const BottomBarItem({
    super.key,
    required this.svgImage,
    required this.index,
    required this.label,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final bottomBarProvider = Provider.of<BottomBarProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isSelected = bottomBarProvider.currentIndex == index;

    return GestureDetector(
      onTap: () {
        bottomBarProvider.updateIndex(index);
        animationController.forward(from: 0.0);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgImage,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(themeProvider.currentTheme.textPrimaryColor , BlendMode.srcIn),
          ),
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: themeProvider.currentTheme.appPrimaryColor,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: themeProvider.currentTheme.appPrimaryColor.withOpacity(0.15), // Neon glow color
                    spreadRadius: 16,
                    blurRadius: 24,
                    offset: const Offset(0, -8), // Shadow position
                  ),
                ],
              ),
              margin: const EdgeInsets.only(top: 4),
              width: 24,
              height: 5,
            ),
        ],
      ),
    );
  }
}
