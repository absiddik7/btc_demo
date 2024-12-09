import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';

class MyDashboardScreen extends StatefulWidget {
  const MyDashboardScreen({super.key});

  @override
  State<MyDashboardScreen> createState() => _MyDashboardScreenState();
}

class _MyDashboardScreenState extends State<MyDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomBackground(
        child: Center(
          child: Text(
            "My Dashboard Screen",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
