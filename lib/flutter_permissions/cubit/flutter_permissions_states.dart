import 'package:flutter_animations_2/flutter_permissions/cubit/state_model/flutter_permission_state_model.dart';

abstract class FlutterPermissionStates {
  FlutterPermissionStateModel flutterPermissionStateModel;

  FlutterPermissionStates({required this.flutterPermissionStateModel});
}

class InitFlutterPermissionState extends FlutterPermissionStates {
  InitFlutterPermissionState(
      FlutterPermissionStateModel flutterPermissionStateModel)
      : super(flutterPermissionStateModel: flutterPermissionStateModel);
}
