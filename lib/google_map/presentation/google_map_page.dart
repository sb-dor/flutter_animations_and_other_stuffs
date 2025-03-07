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
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!currentState.selectingUserDestination)
              FloatingActionButton(
                onPressed: () async =>
                    context.read<MainGoogleMapCubit>().startToSelectDestination(),
                child: const Icon(Icons.two_wheeler_sharp),
              ),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () async =>
                  await context.read<MainGoogleMapCubit>().getApproximateTimeOfUserLocation(),
              child: const Icon(Icons.location_on_outlined),
            )
          ],
        ),
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
          polylines: Set<Polyline>.of(currentState.polyLines.values),
          onTap: (LatLng latLng) =>
              // context.read<MainGoogleMapCubit>().addMarkerByClickOnMap(latLng),
              // context.read<MainGoogleMapCubit>().animateAndMoveCameraOnTap(latLng),
              currentState.selectingUserDestination
                  ? context.read<MainGoogleMapCubit>().addTwoPolyLinesBetweenTwoDestinations(latLng)
                  : null,
        ),
      );
    });
  }
}
