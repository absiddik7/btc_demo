import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:provider/provider.dart';

class DatePickerIconButton extends StatelessWidget {
  final String selectedDate;
  final VoidCallback? onPressed;

  const DatePickerIconButton({
    super.key,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Access dynamic colors from the theme provider
        final Color backgroundColor =
            themeProvider.currentTheme.appSecondaryColor;
        final Color textColor = selectedDate.isEmpty
            ? themeProvider.currentTheme.textSecondaryColor
            : themeProvider.currentTheme.textPrimaryColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize:
                const Size(double.infinity, 40), 
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            backgroundColor: backgroundColor, 
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: themeProvider.currentTheme.borderColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IgnorePointer(
                  child: TextField(
                    controller: TextEditingController(text: selectedDate),
                    decoration: const InputDecoration(
                      hintText: 'Select',
                      hintStyle: TextStyle(color: Color(0xFF999999)),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor, 
                    ),
                    readOnly: true, 
                  ),
                ),
              ),
              SvgPicture.asset(
                AppAssets.calendarIcon,
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
