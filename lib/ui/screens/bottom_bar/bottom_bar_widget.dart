import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/screens/bottom_bar/bottom_bar_item.dart';
import 'package:provider/provider.dart';

// class BottomBarWidget extends StatefulWidget {
//   final AnimationController animationController;
//   final Function(int) onTabSelected;

//   const BottomBarWidget({super.key, required this.animationController, required this.onTabSelected});

//   @override
//   State<BottomBarWidget> createState() => _BottomBarWidgetState();
// }

// class _BottomBarWidgetState extends State<BottomBarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BottomBarProvider>(
//       builder: (context, bottomBarProvider, child) {
//         return BottomBar(
//           width: double.infinity,
//           duration: const Duration(milliseconds: 1000),
//           borderRadius: BorderRadius.circular(50),
//           showIcon: false,
//           barColor: Colors.black38,
//           body: (context, controller) => Container(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 BottomBarItem(
//                   svgImage: ImageContant.homeIcon,
//                   index: 0,
//                   label: 'Home',
//                   isActive: bottomBarProvider.currentIndex == 0, // Check if this is the active tab
//                   onTap: () {
//                     widget.onTabSelected(0); // Trigger page change
//                   },
//                   animationController: widget.animationController,
//                 ),
//                 BottomBarItem(
//                   svgImage: ImageContant.dashboardIcon,
//                   index: 1,
//                   label: 'Dashboard',
//                   isActive: bottomBarProvider.currentIndex == 1,
//                   onTap: () {
//                     widget.onTabSelected(1);
//                   },
//                   animationController: widget.animationController,
//                 ),
//                 BottomBarItem(
//                   svgImage: ImageContant.discoverIcon,
//                   index: 2,
//                   label: 'Discover',
//                   isActive: bottomBarProvider.currentIndex == 2,
//                   onTap: () {
//                     widget.onTabSelected(2);
//                   },
//                   animationController: widget.animationController,
//                 ),
//                 BottomBarItem(
//                   svgImage: ImageContant.myBitcoinIcon,
//                   index: 3,
//                   label: 'MyBitcoin',
//                   isActive: bottomBarProvider.currentIndex == 3,
//                   onTap: () {
//                     widget.onTabSelected(3);
//                   },
//                   animationController: widget.animationController,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class BottomBarWidget extends StatefulWidget {
  final AnimationController animationController;

  const BottomBarWidget({super.key, required this.animationController});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return BottomBar(
          width: double.infinity,
          duration: const Duration(milliseconds: 1000),
          borderRadius: BorderRadius.circular(50),
          barDecoration: themeProvider.isDarkMode? null : BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: themeProvider.currentTheme.textSecondaryColor.withOpacity(0.3),
                spreadRadius: 0.0005,
                blurRadius: 0.0005,
                offset: const Offset(0, -0.3),
              ),
            ],
          ),
          hideOnScroll: true,
          showIcon: false,
          barColor: themeProvider.isDarkMode? themeProvider.currentTheme.bottomSheetBackgroundColor : themeProvider.currentTheme.appSecondaryColor,
          body: (context, controller) => Container(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomBarItem(
                  svgImage: AppAssets.homeIcon,
                  index: 0,
                  label: 'Home',
                  animationController: widget.animationController,
                ),
                BottomBarItem(
                  svgImage: AppAssets.dashboardIcon,
                  index: 1,
                  label: 'Dashboard',
                  animationController: widget.animationController,
                ),
                BottomBarItem(
                  svgImage: AppAssets.discoverIcon,
                  index: 2,
                  label: 'Discover',
                  animationController: widget.animationController,
                ),
                BottomBarItem(
                  svgImage: AppAssets.myBitcoinIcon,
                  index: 3,
                  label: 'MyBitcoin',
                  animationController: widget.animationController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}