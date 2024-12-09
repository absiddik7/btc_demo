import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/bottom_bar/bottom_bar_provider.dart';
import 'package:mybtccanvas/ui/screens/bottom_bar/bottom_bar_widget.dart';
import 'package:provider/provider.dart';

// class BottomBarScreen extends StatefulWidget {
//   const BottomBarScreen({super.key});

//   @override
//   State<BottomBarScreen> createState() => _BottomBarScreenState();
// }

// class _BottomBarScreenState extends State<BottomBarScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _pageController = PageController(initialPage: 0);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<BottomBarProvider>(
//         builder: (context, bottomBarProvider, child) {
//           return Stack(
//             children: [
//               // PageView handles page transitions with sliding effect
//               PageView.builder(
                
//                 controller: _pageController,
//                 itemCount: bottomBarProvider.pages.length,
//                 onPageChanged: (index) {
//                   bottomBarProvider.updateIndex(index); // Update selected tab index
//                 },
//                 physics: const ClampingScrollPhysics(), // Smooth swipe physics
//                 itemBuilder: (context, index) {
//                   return bottomBarProvider.pages[index];
//                 },
//               ),
              
//               // Floating BottomBarWidget positioned at the bottom
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: BottomBarWidget(
//                   animationController: _animationController,
//                   onTabSelected: (index) {
//                     // Animate page change on tab click
//                     _pageController.animateToPage(
//                       index,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut, // Smooth slide transition
//                     );
//                     bottomBarProvider.updateIndex(index); // Update provider state
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      //animationBehavior: AnimationBehavior.normal
    );
    _pageController = PageController(initialPage: 0, );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomBarProvider>(
        builder: (context, bottomBarProvider, child) {
          return Stack(
            
            children: [
              bottomBarProvider.currentPage,

              // PageView.builder(
              //   controller: _pageController,
              //   itemCount: bottomBarProvider.pages.length,
              //   onPageChanged: (index) {
              //     bottomBarProvider.updateIndex(index);
              //   },
              //   physics: const ClampingScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     return AnimatedBuilder(
              //       animation: _pageController,
                    
              //       builder: (context, child) {
              //         double value = 1.0;
              //         if (_pageController.position.haveDimensions) {
              //           value = _pageController.page! - index;
              //           value = (1 - (value.abs() * 0.0)).clamp(0.0, 1.0);
              //         }
              //         return Transform(
              //           transformHitTests: true,

              //           transform: Matrix4.identity()
              //             ..scale(value, value),

              //           child: bottomBarProvider.currentPage,
              //         );
              //       },
              //     );
              //   },
              // ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomBarWidget(
                  animationController: _animationController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



// class BottomBarScreen extends StatefulWidget {
//   const BottomBarScreen({super.key});

//   @override
//   State<BottomBarScreen> createState() => _BottomBarScreenState();
// }

// class _BottomBarScreenState extends State<BottomBarScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         body: Consumer<BottomBarProvider>(
//           builder: (context, bottomBarProvider, child) {
//             return Stack(
//               children: [
//                 AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 100),
//                   switchInCurve: Curves.ease,
//                   switchOutCurve: Curves.ease,
//                   child: bottomBarProvider.currentPage,
//                 ),

//                 // AnimatedSwitcher(
//                 //   duration: const Duration(milliseconds: 300),
//                 //   transitionBuilder: (Widget child, Animation<double> animation) {
//                 //     return ScaleTransition(
//                 //       scale: animation,
//                 //       child: child,
//                 //     );
//                 //   },
//                 //   child: bottomBarProvider.currentPage,
//                 // ),

//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: BottomBarWidget(
//                     animationController: _animationController,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }