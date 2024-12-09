import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/screens/discover/discover_explore/discover_screen.dart';
import 'package:mybtccanvas/ui/screens/home/home_screen.dart';
import 'package:mybtccanvas/ui/screens/my_bitcoin/my_bitcoin_screen.dart';
import 'package:mybtccanvas/ui/screens/my_dashboard/my_dashboard_screen.dart';

// class BottomBarProvider with ChangeNotifier {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();

//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const MyDashboardScreen(),
//     const DiscoverScreen(),
//     const MyBitcoinScreen(),
//   ];

//   int get currentIndex => _currentIndex;

//   List<Widget> get pages => _pages;

//   PageController get pageController => _pageController;

//   void updateIndex(int index) {
//     if ((_currentIndex - index).abs() > 1) {
//       // Move to the target page without showing the intermediate pages
//       int tempIndex = index > _currentIndex ? index - 1 : index + 1;
      
//       _pageController.jumpToPage(tempIndex); // Move to a page closer to the target

//       // Ensure the animation runs smoothly
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _pageController.animateToPage(
//           index,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       });
//     } else {
//       _pageController.animateToPage(
//         index,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
    
//     _currentIndex = index;
//     notifyListeners();
//   }
// }





class BottomBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const MyDashboardScreen(),
    const DiscoverScreen(),
    const MyBitcoinScreen(),
  ];

  int get currentIndex => _currentIndex;

  List<Widget> get pages => _pages;

  Widget get currentPage => _pages[_currentIndex];

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}