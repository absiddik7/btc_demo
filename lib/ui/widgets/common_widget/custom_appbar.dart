import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_icons.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  final String? title;
  final bool showBackButton;
  final Widget? trailingIcon;
  final Function? onBackButtonPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.trailingIcon,
    this.onBackButtonPressed,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool _showBackButton;

  @override
  void initState() {
    super.initState();
    _showBackButton = widget.showBackButton;
  }

  void toggleBackButton() {
    setState(() {
      _showBackButton = !_showBackButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final textColor = themeProvider.currentTheme.textPrimaryColor;
        const appBarColor = Colors.transparent;

        return Container(
          margin: const EdgeInsets.only(top: 30),
          height: 56,
          decoration: const BoxDecoration(
            color: appBarColor,
          ),
          child: Stack(
            children: [
              if (_showBackButton)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    splashRadius: 0.1,
                    icon: const CustomIconButton(
                      type: IconButtonType.popButton,
                    ),
                    onPressed: () {
                      // Use the custom navigation function if provided, otherwise pop the current screen
                      if (widget.onBackButtonPressed != null) {
                        widget.onBackButtonPressed!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),

              // Centered title text
              Center(
                child: Text(
                  widget.title!,
                  style: AppTextStyles.outfitR16(color: textColor),
                ),
              ),

              widget.trailingIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Align(alignment: Alignment.centerRight, child: widget.trailingIcon),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
