import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart'; // Your ThemeProvider
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart'; // For your style constants
import 'package:provider/provider.dart'; // For accessing the theme provider

class PeriodSelectorBottomSheet extends StatefulWidget {
  const PeriodSelectorBottomSheet({super.key});

  @override
  State<PeriodSelectorBottomSheet> createState() =>
      _PeriodSelectorBottomSheetState();
}

class _PeriodSelectorBottomSheetState extends State<PeriodSelectorBottomSheet> {
  int _selectedPeriod = 2;

  @override
  Widget build(BuildContext context) {
    final List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
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
                'Bitcoin price period',
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
                        initialItem: _selectedPeriod,
                      ),
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _selectedPeriod = selectedItem;
                        });
                      },
                      // No need for selection overlay here because we're adding it manually in the Stack
                      selectionOverlay: Container(),
                      children:
                          List<Widget>.generate(periods.length, (int index) {
                        final bool isSelected = index == _selectedPeriod;
                        return Center(
                          child: Text(
                            periods[index],
                            style: TextStyle(
                              color: isSelected
                                  ? magnifiedTextColor
                                  : pickerTextColor,
                              fontSize: isSelected
                                  ? 24
                                  : 22, // Magnified text is bold
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
