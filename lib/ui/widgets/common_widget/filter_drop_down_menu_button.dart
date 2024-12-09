import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class FilterDropDownMenuButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const FilterDropDownMenuButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    //theme provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
    final Color textColor = themeProvider.currentTheme.textPrimaryColor;
    final Color iconColor = themeProvider.currentTheme.textPrimaryColor;
    final Color borderColor = themeProvider.currentTheme.borderColor;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 32),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: borderColor,
          ),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.outfitR14(
              color: textColor,
            ),
          ),
          const SizedBox(width: 6),
          SvgPicture.asset(
            AppAssets.dropdownIcon,
            colorFilter: ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
