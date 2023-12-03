import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class YoutubeExplodePage extends StatefulWidget {
  const YoutubeExplodePage({Key? key}) : super(key: key);

  @override
  State<YoutubeExplodePage> createState() => _YoutubeExplodePageState();
}

class _YoutubeExplodePageState extends State<YoutubeExplodePage> {
  String videoId = 'orbkg5JH9C8';

  late YoutubePlayerController _controller;

  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  List<int> videoInt = [];

  bool downloadingFile = false;

  // this variable will be shown as animation for downloading progress
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

  Future<void> _getVideoInformationWithYTExplode(
      {required String videoId, bool audioOfVideo = false}) async {
    downloadingFile = true;
    percentage = 0.0;
    setState(() {});
    try {
      var video = await _youtubeExplode.videos.get(videoId);

      var manifest = await _youtubeExplode.videos.streamsClient.getManifest(videoId);

      // all videos without audio
      for (var each in manifest.videoOnly) {
        debugPrint("_____________");
        debugPrint("each file size: ${each.size.totalMegaBytes}");
        debugPrint("each file video quality: ${each.videoQuality.name}");
        debugPrint("each file video resolution: ${each.videoResolution}");
        debugPrint("each file video url: ${each.url}");
        debugPrint("_____________");
      }

      // all audios without video
      for (var each in manifest.audioOnly) {
        debugPrint("_____________");
        debugPrint("each file size: ${each.size.totalMegaBytes}");
        debugPrint("each file video url: ${each.url}");
        debugPrint("_____________");
      }

      // to get first video which mb is more than 1mb and less than 2mb
      var videoMoreThatOneMb = manifest.videoOnly.firstWhereOrNull(
          (element) => element.size.totalMegaBytes >= 1.0 && element.size.totalMegaBytes <= 2);

      // check if this kind of video exist or not
      var checkForExists = videoMoreThatOneMb ?? manifest.videoOnly.first;

      // at least send that video which is more that 1MB and first audio of an array
      await _createFilesFromAudioAndVideo(
          checkForExists.url.toString(), manifest.audioOnly.first.url.toString());

      //
      // high quality of video and audio
      var videoOnlyUrl = manifest.videoOnly.withHighestBitrate().toString(); //
      var audioOnlyUrl = manifest.audioOnly.withHighestBitrate().url.toString(); // just a audio

      var videoUrl = manifest.video.withHighestBitrate().url.toString(); // just a video
      var videoWithAudioUrl =
          manifest.audio.withHighestBitrate().url.toString(); //video with audio url
      //
      //

      // for downloading
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
      percentage = 0.0;
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
      percentage = 0.0;
      setState(() {});
      debugPrint("error is $e");
    }
  }

  // this func created temp files in storage from video and audio
  // than calling function "_concatenateAudioAndVideo()" combines video and audio
  Future<void> _createFilesFromAudioAndVideo(String videoPath, String audioPath) async {
    dev.log("paths are: $videoPath | $audioPath");
    var videoFromUrl = await Dio().get<List<int>>(videoPath,
        options: Options(responseType: ResponseType.bytes, headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }));

    var audioFromUrl = await Dio().get<List<int>>(audioPath,
        options: Options(responseType: ResponseType.bytes, headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        }));

    var tempPath = await getTemporaryDirectory();

    var newVideoPath = "${tempPath.path}/newVideoPath.mp4";
    var newAudioPath = "${tempPath.path}/newAudioPath.mp3";

    File newVideoFile = File(newVideoPath);
    File newAudioFile = File(newAudioPath);

    newVideoFile.writeAsBytesSync(videoFromUrl.data ?? []);
    newAudioFile.writeAsBytesSync(audioFromUrl.data ?? []);

    await _concatenateAudioAndVideo(videoPath: newVideoFile.path, audioPath: newAudioFile.path);
  }

  Future<void> _concatenateAudioAndVideo(
      {required String videoPath, required String audioPath}) async {
    var getExStorage = await getExternalStorageDirectory();

    // create output path where file will be saved
    String outputPath =
        '${getExStorage?.path}/${Random().nextInt(pow(2, 10).toInt())}.mp4'; // remember to rename file all the time, other way file will be replaced with another file

    // package
    await FFmpegKit.execute('-i $videoPath -i $audioPath -c copy $outputPath').then((value) async {
      final returnCode = await value.getReturnCode();
      debugPrint("result of audio and video");

      if (ReturnCode.isSuccess(returnCode)) {
        debugPrint("SUCCESS");
      } else if (ReturnCode.isCancel(returnCode)) {
        debugPrint("CANCEL");
      } else {
        debugPrint("ERROR");
      }
    });
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
                await _getVideoInformationWithYTExplode(videoId: videoId, audioOfVideo: true);
              },
              child: downloadingFile
                  ? SizedBox(
                      width: 30,
                      height: 30,
                      child: percentage == 0.0
                          ? const CircularProgressIndicator()
                          : CircularProgressIndicator(value: percentage))
                  : const Icon(Icons.download))
        ])
      ]),
    );
  }
}
