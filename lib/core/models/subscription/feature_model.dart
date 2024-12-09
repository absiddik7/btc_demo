// Class to represent each feature with its availability in Free and Pro plans
class Feature {
  final String name;
  final String free;
  final String pro;

  Feature({
    required this.name,
    required this.free,
    required this.pro,
  });
}