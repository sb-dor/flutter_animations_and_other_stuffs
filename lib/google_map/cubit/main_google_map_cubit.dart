import 'package:flutter/material.dart';
import 'package:flutter_animations_2/google_map/cubit/state_model/google_map_state_model.dart';
import 'package:flutter_animations_2/google_map/google_api_key_env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'google_map_states.dart';
import 'package:location/location.dart';

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
      debugPrint("address: ${address.name}");
    }
  }

  Future<void> getApproximateTimeOfUserLocation() async {
    _currentState.serviceEnabled = await _currentState.location.serviceEnabled();
    if (!_currentState.serviceEnabled) {
      _currentState.serviceEnabled = await _currentState.location.requestService();
    }
    if (!_currentState.serviceEnabled) return;

    _currentState.status = await _currentState.location.hasPermission();

    if (_currentState.status == PermissionStatus.denied) {
      _currentState.status = await _currentState.location.requestPermission();
    }
    if (_currentState.status != PermissionStatus.granted) return;

    bool isBackModeEnable = await _currentState.location.isBackgroundModeEnabled();

    if (!isBackModeEnable) {
      await _currentState.location.enableBackgroundMode(enable: true);
    }

    await for (var each in _currentState.location.onLocationChanged) {
      debugPrint("each listening position: ${each.latitude} | ${each.longitude}");
      final latLong = LatLng(each.latitude ?? 0, each.longitude ?? 0);
      _currentState.controller.animateCamera(
        CameraUpdate.newLatLng(latLong),
      );
      _createPolyLineOnUserNavigation(latLong);
    }
  }

  void _createPolyLineOnUserNavigation(LatLng latLng) async {
    PolylineId polylineId = const PolylineId("user_navigation_id");
    final polyline = _currentState.polyLines[polylineId];

    if (polyline != null) {
      List<LatLng> navigations = polyline.points.map((e) => e).toList();
      navigations.add(latLng);
      final newPolyLine = polyline.copyWith(pointsParam: navigations);
      _currentState.polyLines[polylineId] = newPolyLine;
    } else {
      final Polyline polyline = Polyline(
          polylineId: polylineId,
          consumeTapEvents: true,
          color: Colors.green,
          width: 5,
          points: [latLng]);
      _currentState.polyLines[polylineId] = polyline;
    }
    debugPrint("polylined: ${_currentState.polyLines[polylineId]?.points}");
    emit(InitialGoogleMapState(_currentState));
  }

  void _clearDestinationsMarks() {
    _currentState.markers
        .removeWhere((key, value) => key.value == "destination_1" || key.value == 'destination_2');
    _currentState.polyLines.removeWhere((key, value) => key.value == 'destination');
    _currentState.polyLineDestinationIds = 0;
  }

  void startToSelectDestination() {
    _currentState.selectingUserDestination = !_currentState.selectingUserDestination;
    if (_currentState.selectingUserDestination) _clearDestinationsMarks();
    emit(InitialGoogleMapState(_currentState));
  }

  void addTwoPolyLinesBetweenTwoDestinations(LatLng latLng) async {
    _currentState.polyLineDestinationIds++;
    MarkerId id = MarkerId("destination_${_currentState.polyLineDestinationIds}");
    Marker marker = Marker(
      markerId: id,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: latLng,
      infoWindow: InfoWindow(title: id.value, snippet: '*'),
    );
    _currentState.markers[id] = marker;

    final Marker? firstMarker = _currentState.markers[const MarkerId("destination_1")];
    final Marker? secondMarker = _currentState.markers[const MarkerId("destination_2")];
    debugPrint("first: ${firstMarker?.position} | second: ${secondMarker?.position}");
    if (firstMarker != null && secondMarker != null) {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_API_KEY,
        PointLatLng(firstMarker.position.latitude, firstMarker.position.longitude),
        PointLatLng(secondMarker.position.latitude, secondMarker.position.longitude),
      );

      const polylineId = PolylineId("destination");

      final polyline = Polyline(
        polylineId: polylineId,
        color: Colors.green,
        width: 5,
        points: result.points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      );

      _currentState.selectingUserDestination = false;
      _currentState.polyLines[polylineId] = polyline;
    }
    emit(InitialGoogleMapState(_currentState));
  }
}
