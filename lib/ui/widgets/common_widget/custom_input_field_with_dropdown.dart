import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:provider/provider.dart'; 

class CustomInputFieldWithDropdown extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String suffixText;
  final VoidCallback? onSuffixPressed;

  const CustomInputFieldWithDropdown({
    super.key,
    required this.hintText,
    this.validator,
    required this.controller,
    this.suffixText = '',
    this.onSuffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Access the colors from the current theme
        final Color backgroundColor =
            themeProvider.currentTheme.appSecondaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color errorColor = themeProvider.currentTheme.errorColor;
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color hintTextColor = themeProvider.currentTheme.hintTextColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: 16, color: hintTextColor), 
                filled: true,
                fillColor: backgroundColor, 
                suffixIcon: GestureDetector(
                  onTap: onSuffixPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          suffixText,
                          style: TextStyle(
                              fontSize: 16,
                              color: textColor), 
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          AppAssets.dropdownIcon,
                          colorFilter: ColorFilter.mode(
                              iconColor, BlendMode.srcIn), 
                        ),
                      ],
                    ),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: borderColor,
                      width: 1), 
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: borderColor,
                      width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: errorColor,
                      width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: errorColor,
                      width: 1), 
                ),
                errorStyle: TextStyle(
                  color: errorColor, 
                  fontSize: 12, 
                ),
              ),
              validator: validator,
              cursorColor: Colors.blue, 
              style: TextStyle(
                  fontSize: 16, color: textColor),
            ),
          ],
        );
      },
    );
  }
}
