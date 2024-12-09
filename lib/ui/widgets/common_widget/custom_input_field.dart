import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';

class CustomInputField extends StatelessWidget {
  final String? label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String suffixText;
  final String? prefixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const CustomInputField({
    super.key,
    this.label,
    required this.hintText,
    this.validator,
    required this.controller,
    this.suffixText = '',
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            if (label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: SizeConstant.paddingSmall),
                child: Text(
                  label!,
                  style: AppTextStyles.outfitSB16(color: textColor),
                ),
              ),
            // Input field
            SizedBox(
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType?? TextInputType.text,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppTextStyles.outfitR16(color: textSecondaryColor),
                  filled: true,
                  fillColor: backgroundColor,
                  prefixIcon: prefixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.all(SizeConstant.paddingMedium),
                          child: SvgPicture.asset(
                            prefixIcon!,
                            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                            width: SizeConstant.iconSizeMedium,
                            height: SizeConstant.iconSizeMedium,
                          ),
                        )
                      : null,
                  // Suffix icon
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: SizeConstant.paddingMedium),
                        child: Text(
                          suffixText,
                          style: AppTextStyles.outfitR16(color: textColor),
                        ),
                      ),
                    ],
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
                validator: validator,
                cursorColor: cursorColor,
                style: AppTextStyles.outfitR16(color: textColor),
                onChanged: onChanged
              ),
            ),
          ],
        );
      },
    );
  }
}
