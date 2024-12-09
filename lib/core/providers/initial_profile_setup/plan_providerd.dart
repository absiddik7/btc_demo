import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/models/subscription/feature_model.dart';
import 'package:mybtccanvas/core/models/subscription/plan_model.dart';
import 'package:mybtccanvas/core/services/local_storage/app_sharedpreference.dart';

class PlanProvider extends ChangeNotifier {
  // Data list for available plans
  final List<Plan> plans = [
    Plan(
      name: 'Annual',
      pricing: '\$7/month, billed once for \$90',
      badge: 'SAVE 30%',
      features: [
        Feature(name: 'Analytics Widget', free: 'Up to 2', pro: 'Unlimited'),
        Feature(name: 'Learnings', free: 'Up to 2', pro: 'Unlimited'),
        Feature(name: 'Advanced Analytics', free: 'No', pro: 'Yes'),
        Feature(name: 'Custom Reports', free: 'No', pro: 'Yes'),
        Feature(name: 'Ad-Free Experience', free: 'Yes', pro: 'Yes'),
      ],
    ),
    Plan(
      name: 'Monthly',
      pricing: '\$10/month',
      badge: '',
      features: [
        Feature(name: 'Analytics Widget', free: 'Up to 2', pro: 'Unlimited'),
        Feature(name: 'Learnings', free: 'Up to 2', pro: 'Unlimited'),
        Feature(name: 'Advanced Analytics', free: 'No', pro: 'Yes'),
        Feature(name: 'Custom Reports', free: 'No', pro: 'Yes'),
        Feature(name: 'Ad-Free Experience', free: 'Yes', pro: 'Yes'),
      ],
    ),
  ];

  String _selectedPlan = 'Annual';
  List<bool> selectedFeaturesFree = [];
  List<bool> selectedFeaturesPro = [];
  String _selectedTier = 'Pro';

  String get selectedPlan => _selectedPlan;
  String get selectedTier => _selectedTier;

  PlanProvider() {
    selectedFeaturesFree = List.filled(plans.first.features.length, false);
    selectedFeaturesPro = List.filled(plans.first.features.length, false);
    _loadSavedPlan();
  }

  Future<void> _loadSavedPlan() async {
    _selectedPlan = await AppSharedPreferences().getPlan();
    notifyListeners();
  }

  Future<void> selectPlan(String planType) async {
    _selectedPlan = planType;
    await AppSharedPreferences().savePlan(planType);
    notifyListeners();
  }

  void selectTier(String tierType) {
    _selectedTier = tierType;
    notifyListeners();
  }

  Plan get selectedPlanDetails => plans.firstWhere(
        (plan) => plan.name == _selectedPlan,
        orElse: () => plans.first,
      );

  void toggleFeatureSelection(int index, bool isFree) {
    if (isFree) {
      selectedFeaturesFree[index] = !selectedFeaturesFree[index];
    } else {
      selectedFeaturesPro[index] = !selectedFeaturesPro[index];
    }
    notifyListeners();
  }

  bool isFeatureSelected(int index, bool isFree) {
    return isFree ? selectedFeaturesFree[index] : selectedFeaturesPro[index];
  }
}
