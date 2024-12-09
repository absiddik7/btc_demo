import 'package:flutter/cupertino.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color trackColor;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = const Color(0xFF8194FF),
    this.trackColor = CupertinoColors.systemGrey4,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
      trackColor: trackColor,
    );
  }
}
