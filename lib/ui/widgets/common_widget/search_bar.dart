import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Import your ThemeProvider
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:provider/provider.dart'; // Import for ThemeProvider access

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onCancel; // Callback for cancel action
  final VoidCallback onItemFound; // Callback for when an item is found

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onCancel, // Added parameter for cancel action
    required this.onItemFound, // Added parameter for item found action
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Access theme-specific colors
        final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color hintTextColor = themeProvider.currentTheme.hintTextColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        return TextField(
          controller: widget.controller,
          onChanged: (value) {
            setState(() {}); // Rebuild to show/hide the clear icon
            // Call the onItemFound callback if a specific condition is met (e.g., value is found)
            if (value == "item") {
              // Change "item" to your condition
              widget.onItemFound();
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 16, color: hintTextColor), // Dynamic hint color
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                AppAssets.searchIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn), // Dynamic icon color
              ),
            ),
            suffixIcon: widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 24,
                      color: iconColor, // Dynamic icon color
                    ),
                    onPressed: () {
                      widget.controller.clear();
                      setState(() {}); // Clear the text and rebuild
                    },
                  )
                : null,
            filled: true,
            fillColor: backgroundColor, // Dynamic background color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: borderColor, // Dynamic border color
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF8194FF), // Dynamic border color from theme
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: borderColor, // Dynamic border color from theme
                width: 1,
              ),
            ),
          ),
          cursorColor: Colors.blue, // Dynamic cursor color
          style: TextStyle(fontSize: 16, color: textColor), // Dynamic text color
        );
      },
    );
  }
}
