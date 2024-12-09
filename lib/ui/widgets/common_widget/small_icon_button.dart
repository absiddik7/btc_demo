import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const SmallIconButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.add,
        size: 20,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
            fontSize: 14, color: Colors.white), // Smaller text size
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(36, 32), // Width: 36px, Height: 32px
        padding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 2), // Remove padding for a tight fit
        backgroundColor: const Color(0xFF8194FF), // Set your desired color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Adjust border radius
        ),
      ),
      onPressed: onPressed,
    );
  }
}
