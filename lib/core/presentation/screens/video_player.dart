import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/core/theme/app_colors.dart';
import 'package:real_estate_app/core/utils/debug.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool _isVideoLoaded = false;
  static VideoPlayerController _createVideoPlayerController() {
    return VideoPlayerController.asset('assets/videos/loading.mp4');
  }

  _destroyController() {
    _controller.dispose();
  }

  @override
  void didUpdateWidget(VideoSplashScreen oldWidget) {
    debug.log("VideoSplashScreen didUpdateWidget", oldWidget != widget);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    debug.log("VideoSplashScreen initState", mounted);
    super.initState();
    _controller = _createVideoPlayerController();
    _initializeVideo();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    debug.log("VideoSplashScreen didChangeDependencies", mounted);
    debug.log("VideoSplashScreen build", _isVideoLoaded);
    super.didChangeDependencies();
  }

  void _initializeVideo() async {
    if (!mounted) {
      return;
    }
    if (_isVideoLoaded) {
      setState(() {
        _isVideoLoaded = false;
      });
    }
    _controller.initialize().then((_) {
      setState(() {
        _isVideoLoaded = true;
      });
      _controller.play(); // Auto-play the video
    });

    // Dispose the splash screen when video finishes
    _controller.removeListener(_videoListener);
    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    debug.log("VideoSplashScreen _videoListener");
    if (_controller.value.isInitialized &&
        _controller.value.position >= _controller.value.duration) {
      _navigateToNextScreen();
    }
  }

  bool _navigated = false;

  void _navigateToNextScreen() async {
    debug.log(
        "VideoSplashScreen _navigateToNextScreen _navigated:", _navigated);
    if (_navigated == true) {
      return;
    }
    _navigated = true;

    context.go("/");
    // Dispose of the controller to prevent memory leaks
    _destroyController();
  }

  @override
  void dispose() {
    // Ensure video controller is disposed when widget is removed
    debug.log("VideoSplashScreen dispose isInitialized:",
        _controller.value.isInitialized);
    if (_controller.value.isInitialized == true) {
      _controller.dispose();
      _controller = _createVideoPlayerController();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debug.log("VideoSplashScreenState $state");
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _controller.pause();
    }

    if (state == AppLifecycleState.resumed && _controller.value.isInitialized) {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground.color,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_isVideoLoaded)
            // Display the video as a full-screen background
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          if (!_isVideoLoaded)
            const Center(
              child: Icon(
                Icons.abc_sharp,
              ),
            ),
        ],
      ),
    );
  }
}
