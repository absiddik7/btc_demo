import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double size;
  final String imagePath;
  final Color backgroundColor;

  const ProfileAvatar({
    super.key,
    required this.size,
    this.imagePath = 'assets/images/avatar.png', // replace with your own image path
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
