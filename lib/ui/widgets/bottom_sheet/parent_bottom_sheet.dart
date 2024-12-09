import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:provider/provider.dart';

class ParentBottomSheet extends StatefulWidget {
  final Widget child;
  final bool? isDismissible;

  const ParentBottomSheet({
    super.key,
    required this.child,
    this.isDismissible = true,
  });

  @override
  State<ParentBottomSheet> createState() => _ParentBottomSheetState();

  static void show(BuildContext context, {required Widget child, bool isDismissible = true}) {
    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PopScope(
        canPop: isDismissible,
        child: ParentBottomSheet(
          child: child,
        ),
      ),
    );
  }
}

class _ParentBottomSheetState extends State<ParentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, childWidget) {
        final Color backgroundColor =
            themeProvider.currentTheme.bottomSheetBackgroundColor;
        final Color borderColor = themeProvider.currentTheme.textSecondaryColor;
        return Container(
          padding: const EdgeInsets.all(SizeConstant.paddingSmall),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(SizeConstant.cornerRadiusMedium),
              topRight: Radius.circular(SizeConstant.cornerRadiusMedium),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38,
                height: 3,
                margin: const EdgeInsets.only(top: SizeConstant.marginSmall),
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: SizeConstant.spaceSmall),
              widget.child,
            ],
          ),
        );
      },
    );
  }
}
