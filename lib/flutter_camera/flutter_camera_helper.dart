import 'package:camera/camera.dart';

class FlutterCameraHelper {
  static FlutterCameraHelper? _instance;

  static FlutterCameraHelper get instance => _instance ??= FlutterCameraHelper._();

  FlutterCameraHelper._();

  late List<CameraDescription> _cameras;

  List<CameraDescription> get cameras => _cameras;

  //init this one in main func
  Future<void> initCameras() async {
    _cameras = await availableCameras();
  }
}
