import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({super.key});

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage>
    with WidgetsBindingObserver {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //do not forget to put your own key in <YOUR_KEY> field                                      for search parameter
    //https://youtube.googleapis.com/youtube/v3/search?part=snippet&key=YOUR_KEY&maxResults=10&q="flutter%20собес%20wtf"

    //for getting comment of video visit this link -> https://developers.google.com/youtube/v3/docs/commentThreads/list?hl=ru

    //for getting comments of comment visit this link ->https://developers.google.com/youtube/v3/docs/comments/list?hl=ru

    _controller = YoutubePlayerController(
        initialVideoId: 'pLBugaPFGrk',
        flags: const YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: true,
          autoPlay: true,
          mute: false,
          loop: false,
        ))
      ..play();
    _controller.addListener(() {
      //video position duration
      debugPrint("position: ${_controller.value.position}");
      debugPrint("quality: ${_controller.value.playbackQuality}");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Youtube Video Player")),
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller),
          builder: (context, player) {
            return Scaffold(
                body: ListView(children: [
              YoutubePlayer(
                aspectRatio: 16 / 9,
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                child: Text(
                  'Title: ${_controller.metadata.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                child: Text(
                  'Author: ${_controller.metadata.author}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                child: Text(
                  'Duration: ${_controller.metadata.duration}',
                ),
              ),
            ]));
          }),
    );
  }
}
