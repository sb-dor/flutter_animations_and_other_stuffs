import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/flutter_permissions_states.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/state_model/flutter_permission_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterPermissionCubit extends Cubit<FlutterPermissionStates> {
  FlutterPermissionCubit() : super(InitFlutterPermissionState(FlutterPermissionStateModel()));

  // it is necessary when you come back from settings.
  // this function will work whenever app will be in resume mode
  void allPermissionChecker() async {
    await notificationPermissionHandler();
    await cameraPermissionHandler();
    await microphonePermissionHandler();
    await locationPermissionHandler();
    await storagePermissionHandler();
  }

  //this function opens setting of application
  void settingOpener() async {
    await openAppSettings();
  }

  //notification permission handler. it is necessary when you come back from settings
  Future<void> notificationPermissionHandler() async {
    var currentState = state.flutterPermissionStateModel;
    var notificationStatus = await Permission.notification.status;

    if (!notificationStatus.isGranted) {
      currentState.notificationPermission = false;
    } else {
      currentState.notificationPermission = true;
    }
    emit(InitFlutterPermissionState(currentState));
  }

  //camera permission handler. it is necessary when you come back from settings
  Future<void> cameraPermissionHandler() async {
    try {
      var currentState = state.flutterPermissionStateModel;

      var cameraPermission = await Permission.camera.status;

      if (!cameraPermission.isGranted) {
        currentState.cameraPermission = false;
      } else {
        currentState.cameraPermission = true;
      }
      emit(InitFlutterPermissionState(currentState));
    } catch (e) {
      debugPrint("camera permission handler error is : $e");
    }
  }

  //microphone permission handler. it is necessary when you come back from settings
  Future<void> microphonePermissionHandler() async {
    var currentState = state.flutterPermissionStateModel;

    var microphonePermission = await Permission.microphone.status;

    if (!microphonePermission.isGranted) {
      currentState.microphonePermission = false;
    } else {
      currentState.microphonePermission = true;
    }

    emit(InitFlutterPermissionState(currentState));
  }

  //location permission handler. it is necessary when you come back from settings
  Future<void> locationPermissionHandler() async {
    var currentState = state.flutterPermissionStateModel;

    var locationPermission = await Permission.location.status;

    if (!locationPermission.isGranted) {
      currentState.locationPermission = false;
    } else {
      currentState.locationPermission = true;
    }

    emit(InitFlutterPermissionState(currentState));
  }

  //storage permission handler. it is necessary when you come back from settings
  Future<void> storagePermissionHandler() async {
    var currentState = state.flutterPermissionStateModel;

    var storagePermission = await Permission.storage.status;

    if (!storagePermission.isGranted) {
      currentState.storagePermission = false;
    } else {
      currentState.storagePermission = true;
    }

    emit(InitFlutterPermissionState(currentState));
  }

  Future<void> requestCameraPermission() async {
    var check = await Permission.camera.status;
    if (!check.isGranted) {
      await Permission.camera.request();
    } else {
      await openAppSettings();
    }
  }

  Future<void> requestMicrophonePermission() async {
    var check = await Permission.microphone.status;

    if (!check.isGranted) {
      await Permission.microphone.request();
    } else {
      await openAppSettings();
    }
  }

  Future<void> requestLocationPermission() async {
    var check = await Permission.location.status;

    if (!check.isGranted) {
      await Permission.location.request();
    } else {
      await openAppSettings();
    }
  }

  Future<void> requestStoragePermission() async {
    var check = await Permission.storage.status;
    if (!check.isGranted) {
      await Permission.storage.request();
    } else {
      await openAppSettings();
    }
  }

  Future<void> multiplePermissionHandler() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.notification,
      Permission.camera,
      Permission.location,
      Permission.microphone,
      Permission.storage
    ].request();

    debugPrint("status of multiple permission handler : $status");
  }
}
