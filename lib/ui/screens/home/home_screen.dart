import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/screens/settings/profile/profile_screen.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/profile_avatar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearchActive = false;

  final searchController = TextEditingController();

  void _toggleSearchBar() {
    setState(() {
      _isSearchActive = !_isSearchActive;
      // Reset item found flag when toggling search
      if (!_isSearchActive) {
        searchController.clear(); // Clear search when closing
      }
    });
  }

  void _onItemFound() {
    setState(() {
      _isSearchActive = false; // Close the search bar if the item is found
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          // Access colors from the theme provider
          final Color textColor = themeProvider.currentTheme.textPrimaryColor;
          final Color subtitleColor = themeProvider.currentTheme.textSecondaryColor;
          final Color iconColor = themeProvider.currentTheme.iconColor;
          final Color borderColor = themeProvider.currentTheme.borderColor;
          final Color iconBackgroundColor = themeProvider.currentTheme.appSecondaryColor;

          return Stack(
            children: [
              // Main Background
              CustomBackground(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // Conditionally show ListTile or Search Bar
                      if (!_isSearchActive)
                        ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (context) => const ProfilePage()));
                            },
                            child: const ProfileAvatar(
                              size: 56,
                              imagePath: AppAssets.profileImg,
                            ),
                          ),
                          title: Text(
                            "Good morning,",
                            style: AppTextStyles.outfitR16(
                              color: themeProvider.isDarkMode ? subtitleColor : textColor,
                            ),
                          ),
                          subtitle: Text(
                            "Jason Wilson",
                            style: AppTextStyles.outfitSB24(
                              color: textColor,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: _toggleSearchBar,
                            child: ClipOval(
                              child: Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                  color: iconBackgroundColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: borderColor,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    AppAssets.searchIcon,
                                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Display Search Bar instead of ListTile when search is active
                      if (_isSearchActive)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomSearchBar(
                            controller: searchController,
                            onCancel: _toggleSearchBar,
                            onItemFound: _onItemFound,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
