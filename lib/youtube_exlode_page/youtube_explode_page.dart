import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:dio/dio.dart';

class YoutubeExplodePage extends StatefulWidget {
  const YoutubeExplodePage({Key? key}) : super(key: key);

  @override
  State<YoutubeExplodePage> createState() => _YoutubeExplodePageState();
}

class _YoutubeExplodePageState extends State<YoutubeExplodePage> {
  String videoId = 'xuP4g7IDgDM';

  late YoutubePlayerController _controller;

  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  List<int> videoInt = [];

  bool downloadingFile = false;

  double percentage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ));
  }

  Future<void> getVideoInformationWithYTExplode(
      {required String videoId, bool audioOfVideo = false}) async {
    downloadingFile = true;
    setState(() {});
    try {
      var video = await _youtubeExplode.videos.get(videoId);

      var manifest = await _youtubeExplode.videos.streamsClient.getManifest(videoId);

      var videoOnlyUrl = manifest.videoOnly.withHighestBitrate().url.toString(); //
      var audioOnlyUrl = manifest.audioOnly.withHighestBitrate().url.toString(); // just a audio

      var videoUrl = manifest.video.withHighestBitrate().url.toString(); // just a video
      var videoWithAudioUrl =
          manifest.audio.withHighestBitrate().url.toString(); //video with audio url

      var videoFromUrl = await Dio().get<List<int>>(audioOfVideo ? audioOnlyUrl : videoWithAudioUrl,
          options: Options(responseType: ResponseType.bytes, headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          }), onReceiveProgress: (int receive, int total) {
        // here is a formula for solving progress of downloading
        var solvePercentage = receive / total * 100;
        percentage = solvePercentage / 100;
        //
        setState(() {});
        debugPrint("receive: $receive | total : $total");
      });

      var getExStorage = await getExternalStorageDirectory();

      var createVideoPath = audioOfVideo
          ? "${getExStorage?.path}/audioName.mp3"
          : "${getExStorage?.path}/videoName.mp4";

      File file = File(createVideoPath);

      if (videoFromUrl.data != null && (videoFromUrl.data ?? []).isNotEmpty) {
        file.writeAsBytesSync(videoFromUrl.data!);
      }

      downloadingFile = false;
      setState(() {});

      // var streamInfo = manifest.audioOnly.first;
      // var videoStream = manifest.video.first;
      //
      // var audioStream = _youtubeExplode.videos.streamsClient.get(streamInfo);
      // var videoFile = _youtubeExplode.videos.streamsClient.get(videoStream);
      //
      // videoFile.listen((event) {
      //   debugPrint("listening: ${event}");
      //   videoInt.addAll(event);
      // }, onDone: () {
      //   downloadingFile = false;
      //   setState(() {});
      // });
    } catch (e) {
      downloadingFile = false;
      setState(() {});
      debugPrint("error is $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Youtube dowloading page"),
      ),
      body: ListView(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onEnded: (v) {
              _controller.play();
            },
          ),
        ),
        Row(children: [
          ElevatedButton(
              onPressed: () async {
                // if (downloadingFile) return;
                await getVideoInformationWithYTExplode(videoId: videoId,audioOfVideo: true);
              },
              child: downloadingFile
                  ? SizedBox(
                      width: 30, height: 30, child: CircularProgressIndicator(value: percentage))
                  : const Icon(Icons.download))
        ])
      ]),
    );
  }
}
