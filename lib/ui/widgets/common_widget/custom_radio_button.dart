import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final Widget? trailingIcon;


  const CustomRadioButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onChanged,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final selectedBorderColor =
            themeProvider.currentTheme.radioButtonBorderColor;
        final unselectedBorderColor = themeProvider.currentTheme.borderColor;
        final textColor = themeProvider.currentTheme.textPrimaryColor;
        final radioFillColor = themeProvider.currentTheme.highlightTextColor;

        return GestureDetector(
          onTap: () => onChanged?.call(!isSelected), // Trigger selection on tap
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: isSelected ? selectedBorderColor : unselectedBorderColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: CupertinoRadio<bool>(
                    value: true,
                    groupValue: isSelected,
                    onChanged: onChanged,
                    fillColor: radioFillColor,
                    activeColor: unselectedBorderColor,
                    inactiveColor: unselectedBorderColor,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                ),
                if (trailingIcon != null) trailingIcon!,
              ],
            ),
          ),
        );
      },
    );
  }
}
