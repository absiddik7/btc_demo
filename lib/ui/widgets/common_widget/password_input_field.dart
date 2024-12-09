import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Import your ThemeProvider
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart'; // For accessing the theme provider

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const PasswordInputField({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText, 
    this.onChanged,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access theme from ThemeProvider
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final borderColor = themeProvider.currentTheme.borderColor;
        final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color textSecondaryColor = themeProvider.currentTheme.textSecondaryColor;
        final Color errorColor = themeProvider.currentTheme.errorColor;
        final Color cursorColor = themeProvider.currentTheme.appThirdColor;
        final Color fieldFocusColor = themeProvider.currentTheme.appThirdColor;

        return TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.outfitR16(color: textSecondaryColor),
            filled: true,
            fillColor: backgroundColor,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(SizeConstant.paddingMedium),
              child: SvgPicture.asset(
                AppAssets.passwordIcon,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                width: SizeConstant.iconSizeMedium,
                height: SizeConstant.iconSizeMedium,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: iconColor,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: SizeConstant.paddingLarge,
              vertical: SizeConstant.paddingMedium,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
              borderSide: BorderSide(
                color: fieldFocusColor,
                width: SizeConstant.borderWidthMedium,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
              borderSide: BorderSide(
                color: borderColor,
                width: SizeConstant.borderWidthMedium,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
              borderSide: BorderSide(
                color: errorColor,
                width: SizeConstant.borderWidthMedium,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConstant.cornerRadiusMedium),
              borderSide: BorderSide(
                color: errorColor,
                width: SizeConstant.borderWidthMedium,
              ),
            ),
            errorStyle: AppTextStyles.outfitR12(color: errorColor),
          ),
          validator: widget.validator,
          cursorColor: cursorColor,
          style: AppTextStyles.outfitR16(color: textColor),
          onChanged: widget.onChanged
        );
      },
    );
  }
}
