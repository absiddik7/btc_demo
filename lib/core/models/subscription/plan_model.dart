// Class to represent each plan
import 'package:mybtccanvas/core/models/subscription/feature_model.dart';

class Plan {
  final String name;
  final String pricing;
  final String badge;
  final List<Feature> features;

  Plan({
    required this.name,
    required this.pricing,
    required this.badge,
    required this.features,
  });
}