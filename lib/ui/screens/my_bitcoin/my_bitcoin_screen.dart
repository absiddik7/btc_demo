import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/screens/initial_profile_setup/setup_flow/profile_setup_flow_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/appearance/appearance_screen.dart';
import 'package:mybtccanvas/ui/screens/settings/language/language_screen.dart';
import 'package:mybtccanvas/ui/screens/temp_screen/bottom_sheet_presentation.dart';
import 'package:mybtccanvas/ui/screens/temp_screen/reusable_components_presentation.dart';
import 'package:mybtccanvas/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/video_player/customized_video_player.dart';

class MyBitcoinScreen extends StatefulWidget {
  const MyBitcoinScreen({super.key});

  @override
  State<MyBitcoinScreen> createState() => _MyBitcoinScreenState();
}

class _MyBitcoinScreenState extends State<MyBitcoinScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomBackground(
        child: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "My Bitcoin Screen",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) => const LanguageScreen()));
                      },
                      child: const Text("Language")),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) => const AppearanceScreen()));
                      },
                      child: const Text("Appearance")),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            CupertinoPageRoute(builder: (context) => const ReusableComponentsPresentation()));
                      },
                      child: const Text("Reusable Component")),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) => const BottomSheetPresentation()));
                      },
                      child: const Text("Bottom Sheet")),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) => const WelcomeScreen()));
                      },
                      child: const Text("Welcome Screen")),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => CustomizedVideoPlayer(
                                  url:
                                      'https://drive.google.com/uc?export=download&id=1eO1dwFu1GY66N8cEckRmIBT7mMNnQlnJ',
                                  onSkip: () {
                                    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const BottomSheetPresentation()));
                                  },
                                  onEnd: () {
                                    Navigator.of(context).pop();
                                  },
                                )));
                      },
                      child: const Text("Video Player")),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => CustomizedVideoPlayer(
                                  url:
                                      'https://drive.google.com/uc?export=download&id=1eO1dwFu1GY66N8cEckRmIBT7mMNnQlnJ',
                                  onSkip: () {
                                    // call pauseOnly from the video player provider
                                    //Provider.of<VideoPlayerProvider>(context, listen: false).pauseOnly();
                                    Navigator.of(context).push(CupertinoPageRoute(
                                        builder: (context) => const ProfileSetupFlowScreen()));
                                  },
                                )));
                      },
                      child: const Text("Initial Profile Setup")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
