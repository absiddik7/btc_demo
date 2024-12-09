import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_radio_button.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';

class CompareToOtherAssetsBottomSheet extends StatefulWidget {
  const CompareToOtherAssetsBottomSheet({super.key});

  @override
  State<CompareToOtherAssetsBottomSheet> createState() =>
      _CompareToOtherAssetsBottomSheetState();
}

class _CompareToOtherAssetsBottomSheetState
    extends State<CompareToOtherAssetsBottomSheet> {
  List<String> compareConditionList = ["Yes", "No"];
  String? selectedCompareCondition = "Yes";

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Compare to other assets',
                  style: AppTextStyles.outfitSB24(color: textColor)),
              const SizedBox(height: 16),
              // Dynamic List of CustomRadioButton
              ListView.builder(
                shrinkWrap: true,
                itemCount: compareConditionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomRadioButton(
                      title: compareConditionList[index],
                      isSelected: compareConditionList[index] ==
                          selectedCompareCondition,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedCompareCondition =
                              compareConditionList[index];
                        });
                      },
                    ),
                  );
                },
              ),
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
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.primary,
                      label: 'Add',
                      onPressed: () {},
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
