import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/google_map/cubit/google_map_states.dart';
import 'package:flutter_animations_2/google_map/cubit/main_google_map_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  static const LatLng center = LatLng(38.53575, 68.77905);
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: center,
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainGoogleMapCubit, GoogleMapStates>(builder: (context, state) {
      var currentState = state.googleMapStateModel;
      return Scaffold(
        body: GoogleMap(
          compassEnabled: false,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          onCameraMove: (cameraPosition) {
            context.read<MainGoogleMapCubit>().onCameraMove(cameraPosition);
          },
          onCameraMoveStarted: () {
            debugPrint("ok");
          },
          onMapCreated: (controller) =>
              context.read<MainGoogleMapCubit>().initController(controller, context),
          markers: Set<Marker>.of(currentState.markers.values),
          onTap: (LatLng latLng) =>
              // context.read<MainGoogleMapCubit>().addMarkerByClickOnMap(latLng),
              context.read<MainGoogleMapCubit>().animateAndMoveCameraOnTap(latLng),
        ),
      );
    });
  }
}
