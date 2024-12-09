import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/providers/discover/video_player_provider.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/size_constant.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/core/utils/localization_extension.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CustomControls extends StatelessWidget {
  final Function? onSkip;
  final Function? onEnd;
  const CustomControls({super.key, this.onSkip, this.onEnd});

  @override
  Widget build(BuildContext context) {
    double iconSize = SizeConstant.iconSizeLarge;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer2<VideoPlayerProvider, ThemeProvider>(
      builder: (context, videoPlayerProvider, themeProvider, _) {
        final controller = videoPlayerProvider.videoPlayerController;
        final position = videoPlayerProvider.position;
        final duration = videoPlayerProvider.duration;

        // Calculate the progress percentage (0.0 to 1.0)
        double progressPercent = (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
        bool isVideoEnd = false;
        if(controller!.value.isInitialized && (controller.value.position >= controller.value.duration)) {
          isVideoEnd = true;
          videoPlayerProvider.pauseAndVisibleControlls();
        }

        return Stack(
          children: [
            videoPlayerProvider.isControlsVisible? GestureDetector(
              onTap: () {
                videoPlayerProvider.toggleControlsVisibility();
              },
              child: Container(
                color: Colors.transparent,
                height: height,
                width: width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Rewind 10 seconds
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(themeProvider.currentTheme.appBlackColor.withOpacity(0.5)),
                      ),
                      icon: Icon(Icons.replay_10_rounded, size: iconSize, color: themeProvider.currentTheme.appPrimaryColor,),
                      onPressed: () {
                        final currentPosition = controller.value.position;
                        videoPlayerProvider.seekTo(
                          currentPosition - const Duration(seconds: 10),
                        );
                      },
                    ),

                    const SizedBox(width: SizeConstant.spaceLarge*2),

                    // Play/pause button
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(themeProvider.currentTheme.appBlackColor.withOpacity(0.5)),
                      ),
                      icon: Icon(
                        videoPlayerProvider.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: iconSize+10.0,
                        color: themeProvider.currentTheme.appPrimaryColor,
                      ),
                      onPressed: () {
                        videoPlayerProvider.playPause();
                      },
                      iconSize: iconSize+10.0,
                    ),

                    const SizedBox(width: SizeConstant.spaceLarge*2),

                    // Fast forward 10 seconds
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(themeProvider.currentTheme.appBlackColor.withOpacity(0.5)),
                      ),
                      icon: Icon(Icons.forward_10_rounded , size: iconSize, color: themeProvider.currentTheme.appPrimaryColor,),
                      onPressed: () {
                        final currentPosition = controller.value.position;
                        final videoDuration = controller.value.duration;
                        if (currentPosition + const Duration(seconds: 10) <
                            videoDuration) {
                          videoPlayerProvider.seekTo(
                            currentPosition + const Duration(seconds: 10),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ) : const SizedBox.shrink(),
                        
            // Time and progress bar
            Container(
              height: height,
              width: width,
              padding: const EdgeInsets.only(bottom: SizeConstant.paddingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  // Fullscreen button
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: SizeConstant.spaceSmall),
                    child: IconButton(
                      icon: Icon(
                        videoPlayerProvider.isFullScreen
                            ? Icons.fullscreen_exit_rounded
                            : Icons.fullscreen_rounded,
                        size: iconSize,
                        color: themeProvider.currentTheme.textPrimaryColor,
                      ),
                      onPressed: () {
                        videoPlayerProvider.toggleFullScreen(context);
                      },
                    ),
                  ),

                  // Progress bar
                  // Progress bar with filled dot overlay
                  Stack(
                    children: [
                      // Video progress bar
                      VideoProgressIndicator(
                        controller,
                        allowScrubbing: true,
                        //padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: SizeConstant.paddingExtraSmall),
                        colors: VideoProgressColors(
                          playedColor: themeProvider.currentTheme.appPrimaryColor,
                          bufferedColor: themeProvider.currentTheme.appGreyColor,
                          backgroundColor: themeProvider.currentTheme.appThirdColor.withOpacity(0.5),
                        ),
                      ),

                      // Filled dot at current progress position
                      // Draggable filled dot at current progress position
                      controller.value.isInitialized? 
                      Positioned(
                        left: MediaQuery.of(context).size.width * progressPercent - 8, // Adjust position based on progress
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            // Get the width of the screen
                            double screenWidth = MediaQuery.of(context).size.width;
              
                            // Calculate the new progress based on drag
                            double newProgress = (details.localPosition.dx / screenWidth).clamp(0.0, 1.0);
              
                            // Set the video position based on the new progress
                            final newDuration = duration * newProgress;
                            videoPlayerProvider.seekTo(newDuration);
                          },
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            decoration: BoxDecoration(
                              color: themeProvider.currentTheme.appPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                    ],
                  ),

                  // Time display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          videoPlayerProvider.formatDuration(position),
                          style: AppTextStyles.outfitR16(color: themeProvider.currentTheme.textPrimaryColor),
                        ),
                        Text(
                          videoPlayerProvider.formatDuration(duration), 
                          style: AppTextStyles.outfitR16(color: themeProvider.currentTheme.textPrimaryColor),
                        ),
                      ],
                    ),
                  ),

                  onSkip != null? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: SizeConstant.spaceLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SizeConstant.spaceMedium),
                        child: CommonButton(
                          type: ButtonType.secondary,
                          isEnabled: !controller.value.isInitialized? false : true,
                          label: isVideoEnd? context.lang.next : context.lang.skip,
                          onPressed:  () {
                            controller.value.isInitialized && !isVideoEnd? videoPlayerProvider.pauseAndVisibleControlls() : null;
                            isVideoEnd? onEnd!() : controller.value.isInitialized? onSkip!() : null;
                          },
                        ),
                      ),
                      const SizedBox(height: SizeConstant.spaceLarge),
                    ],
                  ) : const SizedBox.shrink(),
                  
                ],
              ),
            ),

            CustomAppBar(
              title: '',
              trailingIcon: IconButton(
                icon: Icon(
                  videoPlayerProvider.isMuted
                      ? Icons.volume_off_rounded
                      : Icons.volume_up_rounded,
                  size: iconSize,
                  color: themeProvider.currentTheme.textPrimaryColor,
                ),
                onPressed: () {
                  videoPlayerProvider.muteUnmute(); // Mute/unmute
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

