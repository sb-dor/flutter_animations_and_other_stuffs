import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/flutter_permissions_cubit.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/flutter_permissions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlutterPermissionsPage extends StatefulWidget {
  const FlutterPermissionsPage({Key? key}) : super(key: key);

  @override
  State<FlutterPermissionsPage> createState() => _FlutterPermissionsPageState();
}

class _FlutterPermissionsPageState extends State<FlutterPermissionsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FlutterPermissionCubit>().allPermissionChecker();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<FlutterPermissionCubit>().allPermissionChecker();
    } else if (state == AppLifecycleState.paused) {
      context.read<FlutterPermissionCubit>().allPermissionChecker();
    } else if (state == AppLifecycleState.detached) {
      context.read<FlutterPermissionCubit>().allPermissionChecker();
    } else if (state == AppLifecycleState.inactive) {
      context.read<FlutterPermissionCubit>().allPermissionChecker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlutterPermissionCubit, FlutterPermissionStates>(builder: (context, state) {
      var currentState = state.flutterPermissionStateModel;
      return Scaffold(
          appBar: AppBar(
            title: const Text("Flutter permissions handler"),
          ),
          body: ListView(children: [
            Row(children: [
              Switch(
                  value: currentState.notificationPermission,
                  onChanged: (v) => context.read<FlutterPermissionCubit>().settingOpener()),
              const SizedBox(width: 10),
              const Expanded(child: Text("Notification Permission"))
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Switch(
                  value: currentState.cameraPermission,
                  onChanged: (v) =>
                      context.read<FlutterPermissionCubit>().requestCameraPermission()),
              const SizedBox(width: 10),
              const Expanded(child: Text("Camera Permission"))
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Switch(
                  value: currentState.microphonePermission,
                  onChanged: (v) =>
                      context.read<FlutterPermissionCubit>().requestMicrophonePermission()),
              const SizedBox(width: 10),
              const Expanded(child: Text("Microphone Permission"))
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Switch(
                  value: currentState.locationPermission,
                  onChanged: (v) =>
                      context.read<FlutterPermissionCubit>().requestLocationPermission()),
              const SizedBox(width: 10),
              const Expanded(child: Text("Location Permission"))
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Switch(
                  value: currentState.storagePermission,
                  onChanged: (v) =>
                      context.read<FlutterPermissionCubit>().requestStoragePermission()),
              const SizedBox(width: 10),
              const Expanded(child: Text("Storage Permission"))
            ]),
            const SizedBox(height: 10),
            Row(children: [
              TextButton(
                  onPressed: () =>
                      context.read<FlutterPermissionCubit>().multiplePermissionHandler(),
                  child: const Text("Multiple permission handler")),
              const SizedBox(width: 10),
              const Expanded(child: Text("Multiple Permission"))
            ])
          ]));
    });
  }
}
