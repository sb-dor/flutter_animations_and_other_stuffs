import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_animations_2/animations/fade_animation.dart';
import 'package:flutter_animations_2/flutter_camera/flutter_camera_helper.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/flutter_permissions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class FlutterCameraPage extends StatefulWidget {
  const FlutterCameraPage({Key? key}) : super(key: key);

  @override
  State<FlutterCameraPage> createState() => _FlutterCameraPageState();
}

class _FlutterCameraPageState extends State<FlutterCameraPage> {
  FlutterCameraHelper flutterCameraHelper = FlutterCameraHelper.instance;
  CameraController? _cameraController;
  List<XFile> pictures = [];
  List<XFile> videos = [];
  bool loadingTakingPicture = false;
  bool isRecording = false;

  double? minZoom;
  double? maxZoom;
  double? averageZoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initController();
  }

  void initController() async {
    _cameraController = CameraController(flutterCameraHelper.cameras[0], ResolutionPreset.max);
    await _cameraController?.initialize();
    minZoom = await _cameraController?.getMinZoomLevel();
    maxZoom = await _cameraController?.getMaxZoomLevel();
    averageZoom = (maxZoom ?? 1) / 2;
    setState(() {});
  }

  void saveImages() async {
    var flutterPermissionCubit = BlocProvider.of<FlutterPermissionCubit>(context);
    await flutterPermissionCubit.storagePermissionHandler();
    if (!flutterPermissionCubit.state.flutterPermissionStateModel.storagePermission) {
      await flutterPermissionCubit.requestCameraPermission();
      return;
    }
    
    var appDirectory = await getExternalStorageDirectory();

    var path = appDirectory?.path;

    for (var picture in pictures) {
      File file = File("$path/${picture.name}");
      file.writeAsBytesSync(await picture.readAsBytes()); 
      await Gal.putImage(picture.path); //save image in gallery
    }

    for (var video in videos) {
      File file = File("$path/${video.name}");
      file.writeAsBytesSync(await video.readAsBytes());
      await Gal.putVideo(video.path); //save image in gallery
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ((_cameraController?.value.isInitialized ?? false) && _cameraController != null)
          ? Stack(
              children: [
                Positioned.fill(child: CameraPreview(_cameraController!)),
                if (pictures.isNotEmpty)
                  Positioned(
                      left: 10,
                      right: 10,
                      bottom: 70,
                      child: SizedBox(
                          height: 100,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(width: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: pictures.length,
                              itemBuilder: (context, index) {
                                return FadeAnimation(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(File(pictures[index].path))));
                              }))),
                if (videos.isNotEmpty)
                  Positioned(
                      left: 10,
                      right: 10,
                      bottom: 180,
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(width: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: videos.length,
                              itemBuilder: (context, index) {
                                return FadeAnimation(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            _VideoPlayerWidget(pathOfVideo: videos[index].path)));
                              }))),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: SizedBox(
                        height: 50,
                        child: Row(children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (loadingTakingPicture) return;
                                  loadingTakingPicture = true;
                                  setState(() {});
                                  var image = await _cameraController?.takePicture();
                                  if (image != null) pictures.add(image);
                                  loadingTakingPicture = false;
                                  setState(() {});
                                },
                                child: loadingTakingPicture
                                    ? const CircularProgressIndicator()
                                    : const Icon(Icons.camera, size: 30)),
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (isRecording) {
                                    var video = await _cameraController?.stopVideoRecording();
                                    if (video != null) videos.add(video);
                                    isRecording = false;
                                  } else {
                                    await _cameraController?.startVideoRecording();
                                    isRecording = true;
                                  }
                                  setState(() {});
                                },
                                child: isRecording
                                    ? const Icon(Icons.emergency_recording_outlined)
                                    : const Icon(Icons.video_camera_back_rounded, size: 30)),
                          )
                        ]))),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: 0,
                    right: 0,
                    child: Row(
                        children: flutterCameraHelper.cameras
                            .map((e) => Expanded(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await _cameraController?.setDescription(e);
                                        setState(() {});
                                      },
                                      child: Text(
                                        e.lensDirection.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ))
                            .toList())),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.04 + 50,
                    left: 0,
                    right: 0,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              _cameraController?.setZoomLevel(minZoom ?? 1);
                            },
                            child: Text(
                              "$minZoom Zoom",
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              _cameraController?.setZoomLevel(maxZoom ?? 1);
                            },
                            child: Text(
                              "$maxZoom Zoom",
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              _cameraController?.setZoomLevel(averageZoom ?? 1);
                            },
                            child: Text(
                              "$averageZoom Zoom",
                              textAlign: TextAlign.center,
                            )),
                      ),
                      if (videos.isNotEmpty || pictures.isNotEmpty)
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async => saveImages(),
                              child: const Text(
                                "Save",
                                textAlign: TextAlign.center,
                              )),
                        )
                    ]))
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final String pathOfVideo;

  const _VideoPlayerWidget({
    Key? key,
    required this.pathOfVideo,
  }) : super(key: key);

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  bool stoppedWithClick = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.pathOfVideo))..initialize();
    _videoPlayerController.play();
    _videoPlayerController.addListener(() async {
      if (stoppedWithClick) return;
      if (_videoPlayerController.value.isCompleted) {
        await _videoPlayerController.play();
      }
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(children: [
        Positioned.fill(child: VideoPlayer(_videoPlayerController)),
        Positioned.fill(
            child: GestureDetector(
                onTap: () async {
                  if (_videoPlayerController.value.isPlaying) {
                    await _videoPlayerController.pause();
                    stoppedWithClick = true;
                  } else {
                    stoppedWithClick = false;
                    await _videoPlayerController.play();
                  }
                  setState(() {});
                },
                child: Container(color: Colors.transparent))),
      ]),
    );
  }
}
