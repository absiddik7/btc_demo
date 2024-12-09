import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/accumulate_for_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/add_new_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/add_widget_menu_option_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/alert_type_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/background_color_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/compare_to_other_assets_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/complete_quiz_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/correct_quiz_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/currency_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/edit_dashboard_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/export_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/frequency_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/incorrect_quiz_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/logout_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/parent_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/period_selector_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/relationship_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/select_board_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/select_time_frame_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/starting_year_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/bottom_sheet/transaction_info_bottom_sheet.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';

class BottomSheetPresentation extends StatelessWidget {
  const BottomSheetPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Bottom Sheets',
            trailingIcon: Icon(Icons.settings, color: Colors.white),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const LogoutBottomSheet(),
                        );
                      },
                      child: const Text('Logout'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => {
                        ParentBottomSheet.show(
                          context,
                          child: const PeriodSelectorBottomSheet(),
                        )
                      },
                      child: const Text('Bitcoin Price Period'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const SelectBoardBottomSheet(),
                        );
                      },
                      child: const Text('Select Board'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const AddNewBottomSheet(),
                        );
                      },
                      child: const Text('Select Widget (Add New)'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const AddWidgetMenuOptioinBottomSheet(),
                        );
                      },
                      child: const Text('Select Widget (Menu Option)'),
                    ),
                    // const SizedBox(height: 8),
                    // ElevatedButton(
                    //   onPressed: () => _showOptionsBottomSheet(context),
                    //   child: const Text('Select Widget (Block Slider)'),
                    // ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const AccumulateForBottomSheet(),
                        );
                      },
                      child: const Text('Accumulate for'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const FrequencyBottomSheet(),
                        );
                      },
                      child: const Text('Frequency'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const CompareToOtherAssetsBottomSheet(),
                        );
                      },
                      child: const Text('Compare to other assets'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const StartingYearBottomSheet(),
                        );
                      },
                      child: const Text('Starting Year'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const CurrencyBottomSheet(),
                        );
                      },
                      child: const Text('Currency'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const AlertTypeBottomSheet(),
                        );
                      },
                      child: const Text('Alert Type'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const RelationshipBottomSheet(),
                        );
                      },
                      child: const Text('Relationship'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const EditDashboardBottomSheet(),
                        );
                      },
                      child: const Text('Edit Dashboard'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: CorrectQuizBottomSheet(
                            onPressed: () {},
                          ),
                        );
                      },
                      child: const Text('Correct Quiz'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: IncorrectQuizBottomSheet(
                            onPressed: () {},
                          ),
                        );
                      },
                      child: const Text('Incorrect Quiz'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: CompleteQuizBottomSheet(
                            correctAnswers: 7,
                            incorrectAnswers: 3,
                            quizTitle:
                                "Welcome to Bitcoin 101, your ultimate getway to understanding the world of Bitcoin.",
                            onPressedFished: () {},
                            onPressedNextCourse: () {},
                          ),
                        );
                      },
                      child: const Text('Complete Quiz'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const ExportBottomSheet(),
                        );
                      },
                      child: const Text('Export'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const TransactionInfoBottomSheet(),
                        );
                      },
                      child: const Text('Transaction information'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const SelectTimeFrameBottomSheet(),
                        );
                      },
                      child: const Text('Select Time Frame (Calendar)'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ParentBottomSheet.show(
                          context,
                          child: const BackgroundColorSelectorBottomSheet(
                            initialColorHex: 'themeColor',
                          ),
                        );
                      },
                      child: const Text('Select Background Color'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
