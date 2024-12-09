import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/initial_profile_setup/plan_providerd.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/screens/initial_profile_setup/select_plan/select_plan_screen.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/red_secondary_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {

  // bool isSubscriptionSelected = false;

  // void selectSubscription() {
  //   setState(() {
  //     isSubscriptionSelected = !isSubscriptionSelected;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Consumer<PlanProvider>(
          builder: (context, planProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: context.lang.subscriptions,
                ),
                const SizedBox(
                  height: SizeConstant.spaceSmall,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const SelectPlanScreen(isInitialSetup: false,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeConstant.appHorizontalPadding),
                  child: planProvider.selectedPlan == 'Annual'? CommonButton(
                      type: ButtonType.primary, 
                      label: context.lang.select_subscription, 
                      onPressed: () {
                        planProvider.selectPlan(planProvider.selectedPlan == 'Annual'? 'Monthly' : 'Annual');
                      }
                    ) : RedSecondaryButton(
                      onPressed: () {
                        planProvider.selectPlan(planProvider.selectedPlan == 'Annual'? 'Monthly' : 'Annual');
                      },
                      title: context.lang.cancel_subscription,
                    ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}