import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For accessing the theme provider
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Your ThemeProvider
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart'; // For your style constants

class AlertTypeBottomSheet extends StatefulWidget {
  const AlertTypeBottomSheet({super.key});

  @override
  State<AlertTypeBottomSheet> createState() => _AlertTypeBottomSheetState();
}

class _AlertTypeBottomSheetState extends State<AlertTypeBottomSheet> {
  int _selectedAlert = 1;

  @override
  Widget build(BuildContext context) {
    final List<String> alertTypleList = [
      'Price Change',
      'Percentage change',
      'Share Change'
    ];
    const double kItemExtent = 48.0;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final textColor = themeProvider.currentTheme.textPrimaryColor;
        final selectionOverlayColor =
            themeProvider.currentTheme.appPrimaryColor;
        final pickerTextColor = themeProvider.currentTheme.textPrimaryColor;
        const magnifiedTextColor = Colors.black;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Alert Type',
                style: AppTextStyles.outfitSB24(color: textColor),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 230,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Adding a custom selection bar overlay on top of the picker
                    IgnorePointer(
                      child: Container(
                        height: kItemExtent,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectionOverlayColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),

                    CupertinoPicker(
                      //magnification: 1.22,
                      squeeze: 1.2,
                      //useMagnifier: true,
                      itemExtent: kItemExtent,
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedAlert,
                      ),
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _selectedAlert = selectedItem;
                        });
                      },
                      // No need for selection overlay here because we're adding it manually in the Stack
                      selectionOverlay: Container(),
                      children: List<Widget>.generate(alertTypleList.length,
                          (int index) {
                        final bool isSelected = index == _selectedAlert;
                        return Center(
                          child: Text(
                            alertTypleList[index],
                            style: TextStyle(
                              color: isSelected
                                  ? magnifiedTextColor
                                  : pickerTextColor,
                              fontSize: isSelected ? 24 : 22,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
