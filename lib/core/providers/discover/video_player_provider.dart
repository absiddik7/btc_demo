import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  VideoPlayerController? _videoPlayerController;
  bool _isPlaying = false;
  bool _isMuted = false;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  bool get isPlaying => _isPlaying;
  bool get isMuted => _isMuted;

  Duration get position => _videoPlayerController?.value.position ?? Duration.zero;
  Duration get duration => _videoPlayerController?.value.duration ?? Duration.zero;

  Future<void> initializePlayer(String url) async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(url),
    );
    await _videoPlayerController!.initialize();
    _isPlaying = true;
    _videoPlayerController!.play(); // Autoplay the video
    notifyListeners();

    // Listen for playback updates to notify UI
    _videoPlayerController!.addListener(() {
      notifyListeners();
    });
  }

  bool _isControlsVisible = false;
  bool get isControlsVisible => _isControlsVisible;

  void toggleControlsVisibility() {
    _isControlsVisible = !_isControlsVisible;
    notifyListeners();

    if (_isControlsVisible) {
      visibilityTimer();
    }
  }

  Timer? _hideControlsTimer;
  void visibilityTimer() {
    // Reset timer if controls are visible again
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(milliseconds: 1500), () {
      if (_isPlaying) {
        _isControlsVisible = false;
        notifyListeners();
      }
    });
  }

  void playPause() {
    if (_isPlaying) {
      _videoPlayerController!.pause();
      _isControlsVisible = true;
    } else {
      _videoPlayerController!.play();
      visibilityTimer();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void muteUnmute() {
    if (_isMuted) {
      _videoPlayerController!.setVolume(1.0); // Unmute
    } else {
      _videoPlayerController!.setVolume(0.0); // Mute
    }
    _isMuted = !_isMuted;
    notifyListeners();
  }

  void seekTo(Duration position) {
    _videoPlayerController!.seekTo(position);
    notifyListeners();
  }

  void pauseAndVisibleControlls() {
    _videoPlayerController!.pause();
    _isPlaying = false;
    _isControlsVisible = true;

    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

  // Toggle Full Screen
  bool _isFullScreen = false; // Track full-screen state
  bool get isFullScreen => _isFullScreen; // Getter for full-screen state

  void toggleFullScreen(BuildContext context) {
    if (_isFullScreen) {
      _exitFullScreen();
    } else {
      _enterFullScreen();
    }
    notifyListeners();
  }

  void _enterFullScreen() {
    _isFullScreen = true;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Hide system UI
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]); // Force landscape orientation
  }

  void _exitFullScreen() {
    _isFullScreen = false;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Show system UI
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); // Force portrait orientation
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    print("disposed called");
    _videoPlayerController?.dispose();
    super.dispose();
  }
}
