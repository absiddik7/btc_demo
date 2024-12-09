import 'dart:math';

import 'package:flutter/material.dart';

class CircularGradientPainter extends CustomPainter {
  CircularGradientPainter({
    required this.progress,
    required this.startColor,
    required this.endColor,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.circleRadius,
  });

  final Color backgroundColor;
  final double circleRadius;
  final Color endColor;
  final double progress;
  final Color startColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Define the SweepGradient with the start at the top (12 o'clock)
    Paint progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: -pi / 2,  // Start the gradient from the top
        endAngle: 3 * pi / 2, // Full circle
        colors: [startColor, endColor],
        transform: const GradientRotation(-pi / 2),  // Rotate the gradient to start from the top
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: circleRadius + strokeWidth))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = circleRadius + strokeWidth / 2; // Add space for the stroke

    // Draw the background circle (optional)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * pi,
      false,
      backgroundPaint,
    );

    // Draw the progress arc, starting from the top
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2.05, // Start from the top (12 o'clock position)
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

