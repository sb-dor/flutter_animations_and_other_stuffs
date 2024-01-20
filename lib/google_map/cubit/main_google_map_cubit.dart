import 'package:flutter/material.dart';
import 'package:flutter_animations_2/google_map/cubit/state_model/google_map_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'google_map_states.dart';

class MainGoogleMapCubit extends Cubit<GoogleMapStates> {
  late GoogleMapStateModel _currentState;

  MainGoogleMapCubit() : super(InitialGoogleMapState(GoogleMapStateModel())) {
    _currentState = state.googleMapStateModel;
  }

  void initController(GoogleMapController controller, BuildContext context) async {
    _currentState.controller = controller;
    await _createMarkerOnCenter(controller, context);
    emit(InitialGoogleMapState(_currentState));
  }

  // for more information about marker checkout this web-site:
  /// [https://github.com/flutter/packages/blob/main/packages/google_maps_flutter/google_maps_flutter/example/lib/place_marker.dart]
  void addMarkerByClickOnMap(LatLng latLng) {
    final String markerIdVal = 'marker_id_${_currentState.lastMarkerId}';
    _currentState.lastMarkerId++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
      // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );
    _currentState.markers[markerId] = marker;
    emit(InitialGoogleMapState(_currentState));
  }

  void onCameraMove(CameraPosition cameraPosition) {
    _changeCenterMarker(cameraPosition);
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? marker = _currentState.markers[markerId];
    if (marker == null) return;
    final MarkerId id = marker.markerId;
    Marker newMarker = marker.copyWith(
        iconParam: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
    _currentState.markers[id] = newMarker;
    emit(InitialGoogleMapState(_currentState));
  }

  Future<void> _createMarkerOnCenter(GoogleMapController controller, BuildContext context) async {
    double centerX =
        (MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio) / 2;
    double centerY =
        (MediaQuery.of(context).size.height * MediaQuery.of(context).devicePixelRatio) / 2;
    MarkerId markerId = const MarkerId("center_marker_id");
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position:
          await controller.getLatLng(ScreenCoordinate(x: centerX.round(), y: centerY.round())),
    );
    _currentState.markers[markerId] = marker;
    emit(InitialGoogleMapState(_currentState));
  }

  void _changeCenterMarker(CameraPosition cameraPosition) {
    MarkerId markerId = const MarkerId('center_marker_id');
    final Marker? centerMarker = _currentState.markers[markerId];
    if (centerMarker == null) return;
    Marker newMarker = centerMarker.copyWith(positionParam: cameraPosition.target);
    _currentState.markers[markerId] = newMarker;
    emit(InitialGoogleMapState(_currentState));
  }

  void animateAndMoveCameraOnTap(LatLng latLng) async {
    _currentState.controller.animateCamera(CameraUpdate.newLatLng(latLng));
    await _findAddressByCoordinatesOnTap(latLng);
  }

  Future<void> _findAddressByCoordinatesOnTap(LatLng latLng) async {
    debugPrint("${latLng.toJson()}");
    final address = await geocode.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    for (final address in address) {
      debugPrint("adress: ${address.name}");
    }
  }
}
