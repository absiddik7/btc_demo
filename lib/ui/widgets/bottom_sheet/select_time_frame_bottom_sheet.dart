import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:provider/provider.dart';

class SelectTimeFrameBottomSheet extends StatefulWidget {
  const SelectTimeFrameBottomSheet({super.key});

  @override
  State<SelectTimeFrameBottomSheet> createState() => _SelectTimeFrameBottomSheetState();
}

class _SelectTimeFrameBottomSheetState extends State<SelectTimeFrameBottomSheet> {
  List<DateTime?> _dates = [];
  final today = DateUtils.dateOnly(DateTime.now());
  String returnDate = '2024-09-30';

  @override
  Widget build(BuildContext context) {
    DateTime parsedReturnDate = returnDate.isNotEmpty ? DateTime.parse(returnDate) : today;

    _dates = returnDate.isNotEmpty ? [parsedReturnDate] : [today];
    String getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
    ) {
      values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
      var valueText = (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

      if (datePickerType == CalendarDatePicker2Type.multi) {
        valueText = values.isNotEmpty
            ? values.map((v) => v.toString().replaceAll('00:00:00.000', '')).join(', ')
            : 'null';
      } else if (datePickerType == CalendarDatePicker2Type.range) {
        if (values.isNotEmpty) {
          final startDate = values[0].toString().replaceAll('00:00:00.000', '');
          final endDate = values.length > 1 ? values[1].toString().replaceAll('00:00:00.000', '') : 'null';
          valueText = '$startDate to $endDate';
        } else {
          return 'null';
        }
      }

      return valueText;
    }

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color backgroundColor = themeProvider.currentTheme.appSecondaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color selectedColor = themeProvider.currentTheme.appThirdColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Select Time Frame',
                style: AppTextStyles.outfitSB24(color: textColor),
              ),
              const SizedBox(height: 20),

              // Calendar View
              Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(
                      color: borderColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayHighlightColor: selectedColor,
                      selectedDayTextStyle: const TextStyle(color: Colors.white),
                      dayTextStyle: TextStyle(color: textColor),
                      yearTextStyle: TextStyle(color: textColor),
                      monthTextStyle: TextStyle(color: textColor),
                      selectedMonthTextStyle: const TextStyle(color: Colors.white),
                      selectedYearTextStyle: const TextStyle(color: Colors.white),
                      weekdayLabelTextStyle: const TextStyle(
                        color: Color(0xFF7F828D),
                        fontWeight: FontWeight.bold,
                      ),
                      controlsTextStyle: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      lastMonthIcon: Icon(
                        Icons.arrow_back_ios,
                        color: iconColor,
                        size: 24,
                      ),
                      nextMonthIcon: Icon(
                        Icons.arrow_forward_ios,
                        color: iconColor,
                        size: 24,
                      ),
                    ),
                    value: _dates,
                    onValueChanged: (dates) => _dates = dates,
                  )),
              const SizedBox(height: 16),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.secondary,
                      label: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.primary,
                      label: 'Add',
                      onPressed: () {
                        print(
                            'Selected Date: ${getValueText(CalendarDatePicker2Config().calendarType, _dates)}');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
