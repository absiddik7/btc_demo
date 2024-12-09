import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';

class PeriodFilter extends StatefulWidget {
  final List<String> periods;
  final String selectedPeriod;
  final ValueChanged<String> onPeriodSelected;

  const PeriodFilter({
    super.key,
    required this.periods,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  State<PeriodFilter> createState() => _PeriodFilterState();
}

class _PeriodFilterState extends State<PeriodFilter> {
  late String _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _selectedPeriod = widget.selectedPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final unselectedTextColor =
            themeProvider.currentTheme.textSecondaryColor;
        final selectedColor = themeProvider.currentTheme.appPrimaryColor;
        final borderColor = themeProvider.currentTheme.borderColor;

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.periods.map((period) {
                final bool isSelected = _selectedPeriod == period;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPeriod = period;
                    });
                    widget.onPeriodSelected(period);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? selectedColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        period,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.black : unselectedTextColor,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
