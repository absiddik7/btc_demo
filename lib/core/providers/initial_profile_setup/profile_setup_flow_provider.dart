import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/models/chart/sample_data.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/ui/screens/initial_profile_setup/interests/interests_screen.dart';
import 'package:mybtccanvas/ui/screens/initial_profile_setup/select_avatar/select_avatar_screen.dart';
import 'package:mybtccanvas/ui/screens/initial_profile_setup/select_plan/select_plan_screen.dart';
import 'package:mybtccanvas/ui/screens/initial_profile_setup/select_theme/select_theme_screen.dart';
import 'package:mybtccanvas/ui/screens/initial_profile_setup/signup_success/signup_success_screen.dart';

class ProfileSetupFlowProvider with ChangeNotifier {
  // List of all available screens
  final List<Widget> screens = [
    const InterestsScreen(),
    const SelectPlanScreen(),
    const SelectThemeScreen(),
    const SelectAvatarScreen(),
    const SignupSuccessScreen(),
  ];

  // List of all available describes options
  final List<Map<String, String>> describesOptions = [
    {
      "icon": AppAssets.star1Icon,
      "label": "I’m Bitcoin Enthusiast",
      "description": "I’m Bitcoin Enthusiast",
    },
    {
      "icon": AppAssets.star2Icon,
      "label": "I’m Bitcoin Newbie",
      "description": "I’m Bitcoin Newbie",
    },
    {
      "icon": AppAssets.star3Icon,
      "label": "I’m Bitcoin Investor",
      "description": "I’m Bitcoin Investor",
    },
  ];

  // List of all available interests
  final List<String> interests = [
    "Decentralization",
    "Cryptography",
    "Financial sovereignty",
    "Transparency",
    "Blockchain technology",
    "Store of value",
    "Security",
    "Global adoption",
  ];

  // Sample data for the chart
  List<ChartSampleData> chartData = [
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729596600000),
        open: 67155.0,
        high: 67336.0,
        low: 67155.0,
        close: 67315.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729598400000),
        open: 67426.0,
        high: 67426.0,
        low: 67271.0,
        close: 67271.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729600200000),
        open: 67250.0,
        high: 67405.0,
        low: 67064.0,
        close: 67064.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729602000000),
        open: 67133.0,
        high: 67133.0,
        low: 66880.0,
        close: 67015.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729603800000),
        open: 66957.0,
        high: 67111.0,
        low: 66889.0,
        close: 67052.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729611000000),
        open: 67520.0,
        high: 67594.0,
        low: 67158.0,
        close: 67158.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729612800000),
        open: 67164.0,
        high: 67412.0,
        low: 67164.0,
        close: 67270.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729614600000),
        open: 67236.0,
        high: 67236.0,
        low: 66938.0,
        close: 66938.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729616400000),
        open: 66952.0,
        high: 67075.0,
        low: 66902.0,
        close: 66956.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729618200000),
        open: 66910.0,
        high: 67333.0,
        low: 66910.0,
        close: 67333.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729620000000),
        open: 67336.0,
        high: 67350.0,
        low: 67267.0,
        close: 67267.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729621800000),
        open: 67296.0,
        high: 67436.0,
        low: 67275.0,
        close: 67341.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729623600000),
        open: 67473.0,
        high: 67478.0,
        low: 67331.0,
        close: 67369.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729625400000),
        open: 67322.0,
        high: 67491.0,
        low: 67322.0,
        close: 67487.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729627200000),
        open: 67535.0,
        high: 67538.0,
        low: 67401.0,
        close: 67493.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729629000000),
        open: 67541.0,
        high: 67541.0,
        low: 67384.0,
        close: 67384.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729630800000),
        open: 67389.0,
        high: 67523.0,
        low: 67389.0,
        close: 67505.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729632600000),
        open: 67491.0,
        high: 67491.0,
        low: 67364.0,
        close: 67421.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729634400000),
        open: 67366.0,
        high: 67487.0,
        low: 67366.0,
        close: 67487.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729636200000),
        open: 67470.0,
        high: 67700.0,
        low: 67470.0,
        close: 67595.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729638000000),
        open: 67643.0,
        high: 67733.0,
        low: 67586.0,
        close: 67724.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729639800000),
        open: 67740.0,
        high: 67740.0,
        low: 67550.0,
        close: 67550.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729641600000),
        open: 67511.0,
        high: 67511.0,
        low: 67291.0,
        close: 67351.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729643400000),
        open: 67395.0,
        high: 67395.0,
        low: 67158.0,
        close: 67187.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729645200000),
        open: 67192.0,
        high: 67212.0,
        low: 67103.0,
        close: 67103.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729647000000),
        open: 67164.0,
        high: 67309.0,
        low: 67140.0,
        close: 67309.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729648800000),
        open: 67291.0,
        high: 67338.0,
        low: 67257.0,
        close: 67291.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729650600000),
        open: 67293.0,
        high: 67321.0,
        low: 67134.0,
        close: 67134.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729652400000),
        open: 67027.0,
        high: 67147.0,
        low: 67027.0,
        close: 67055.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729654200000),
        open: 67077.0,
        high: 67120.0,
        low: 66885.0,
        close: 66885.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729656000000),
        open: 66879.0,
        high: 67048.0,
        low: 66879.0,
        close: 67048.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729657800000),
        open: 67025.0,
        high: 67100.0,
        low: 67025.0,
        close: 67025.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729659600000),
        open: 67039.0,
        high: 67175.0,
        low: 67039.0,
        close: 67144.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729661400000),
        open: 67169.0,
        high: 67173.0,
        low: 67050.0,
        close: 67050.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729663200000),
        open: 67063.0,
        high: 67101.0,
        low: 67009.0,
        close: 67052.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729665000000),
        open: 67039.0,
        high: 67195.0,
        low: 67039.0,
        close: 67190.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729666800000),
        open: 67242.0,
        high: 67259.0,
        low: 66907.0,
        close: 66907.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729668600000),
        open: 66863.0,
        high: 66949.0,
        low: 66818.0,
        close: 66909.0),
    ChartSampleData(
        x: DateTime.fromMillisecondsSinceEpoch(1729670400000),
        open: 66906.0,
        high: 66906.0,
        low: 66749.0,
        close: 66806.0),
  ];

  String? _selectedPlan;
  String? selectedDescription;
  List<String> selectedInterests = [];
  int _currentScreenIndex = 0;

  String? get selectedPlan => _selectedPlan;
  bool get isDescriptionSelected => selectedDescription != null;
  bool get isInterestSelected => selectedInterests.isNotEmpty;

  int get totalScreens => screens.length;
  int get currentScreenIndex => _currentScreenIndex;

  // Method to select a plan
  void selectPlan(String plan) {
    _selectedPlan = plan;
    notifyListeners();
  }

  // Add or remove interest tags
  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    notifyListeners();
  }

  // Select a description
  void selectDescription(String description) {
    selectedDescription = description;
    notifyListeners();
  }

  // Set the current screen index and notify listeners
  void setCurrentScreenIndex(int index) {
    _currentScreenIndex = index;
    notifyListeners();
  }

  // Calculate progress based on the current screen
  double get progress {
    return (_currentScreenIndex + 1) / totalScreens;
  }

  // Reset the flow, typically used when the flow is restarted
  void resetFlow() {
    _currentScreenIndex = 0;
    notifyListeners();
  }
}
