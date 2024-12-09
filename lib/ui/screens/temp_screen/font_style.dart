import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';

class FontStyle extends StatefulWidget {
  const FontStyle({super.key});

  @override
  State<FontStyle> createState() => _FontStyleState();
}

class _FontStyleState extends State<FontStyle> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomBackground(
        child: SizedBox(
          height: height,
          width: width,
          child: const SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}