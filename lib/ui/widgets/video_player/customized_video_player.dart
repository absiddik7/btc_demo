import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/discover/video_player_provider.dart';
import 'package:mybtccanvas/ui/widgets/video_player/custom_controls.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/play_button.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CustomizedVideoPlayer extends StatelessWidget {
  final String url;
  final Function? onSkip;
  final Function? onEnd;

  const CustomizedVideoPlayer({super.key, required this.url, this.onSkip, this.onEnd});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoPlayerProvider()..initializePlayer(url),
      child: Scaffold(
        body: CustomBackground(
          child: Stack(
            children: [
              Center(
                child: Consumer<VideoPlayerProvider>(
                  builder: (context, videoProvider, child) {
                    final controller = videoProvider.videoPlayerController;
                    return controller != null &&
                            controller.value.isInitialized
                        ? Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    videoProvider.toggleControlsVisibility();
                                  },
                                  child: AspectRatio(
                                    aspectRatio: controller.value.aspectRatio,
                                    child: VideoPlayer(controller),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Container(
                          height: 80,
                          width: 80,  
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: const PlayButton(
                            iconSize: 32,
                          ),
                        );
                        //: const CircularProgressIndicator();
                  },
                ),
              ),
              CustomControls(onSkip: onSkip, onEnd: onEnd,), // Use your custom controls
            ],
          ),
        ),
      ),
    );
  }
}