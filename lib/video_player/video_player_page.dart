import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;

  late AnimationController _animationController;
  late Animation<double> pauseStopAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    pauseStopAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    //not video from youtube
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('http://192.168.100.244:8000/api/get/video'),
    )
      ..initialize().then((value) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video player")),
      body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                    _animationController
                      ..reset()
                      ..forward();
                  } else {
                    _controller.play();
                    _animationController.reverse();
                  }
                },
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: SizedBox(
                          height: 10,
                          child: VideoProgressIndicator(_controller, allowScrubbing: true)),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.pause_play,
                            progress: pauseStopAnimation,
                            color: Colors.white,
                            size: 40 ,
                          ),
                        ))
                  ],
                ),
              ))),
    );
  }
}
