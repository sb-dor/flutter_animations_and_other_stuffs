import 'package:flutter/material.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_states.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/state_model/map_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainMapCubit extends Cubit<MainMapStates> {
  MainMapCubit() : super(InitialMapStates(MapStateModel()));


  //use init in first initState of map to initialize the map variables
  void initMap() {
    var currentState = state.mapStateModel;
    //initializing map objects that fade in map screen

    //
    currentState.cameraMapObject = PlacemarkMapObject(
        mapId: currentState.cameraMapObjectId,
        point: const Point(latitude: 38.576271, longitude: 68.779716),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage("assets/icons/transparent_pic.png"),
            scale: 0.170)),
        opacity: 0.5);
    //38.589252 68.742095
    currentState.firstObject = PlacemarkMapObject(
        mapId: currentState.firstPlaceMarkId,
        point: const Point(latitude: 38.589252, longitude: 68.742095),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage("assets/pic/alshema_circle_png_map.png"),
            scale: 0.3)),
        opacity: 0.5,
        onTap: (placeMark, point) async {
          if (currentState.loadingMap) return;
          currentState.loadingMap = true;
          // ReUsableGlobalWidgets.showMapInfo(
          //     context: GlobalContextHelper.navigatorKey.currentContext!);
          await currentState.controller.moveCamera(
              CameraUpdate.newCameraPosition(const CameraPosition(
                  target: Point(latitude: 38.589252, longitude: 68.742095), zoom: 13)),
              animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1));

          currentState.loadingMap = false;
        });
    currentState.secondObject = PlacemarkMapObject(
        mapId: currentState.secondPlaceMarkId,
        point: const Point(latitude: 38.548496, longitude: 68.772179),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage("assets/pic/alshema_circle_png_map.png"),
            scale: 0.3)),
        opacity: 0.5,
        onTap: (placeMark, point) async {
          if (currentState.loadingMap) return;
          currentState.loadingMap = true;
          // ReUsableGlobalWidgets.showMapInfo(
          //     context: GlobalContextHelper.navigatorKey.currentContext!);
          await currentState.controller.moveCamera(
              CameraUpdate.newCameraPosition(const CameraPosition(
                  target: Point(latitude: 38.548496, longitude: 68.772179), zoom: 13)),
              animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1));

          currentState.loadingMap = false;
        });
    currentState.mapObjects = [
      currentState.cameraMapObject,
      currentState.firstObject,
      currentState.secondObject
    ];
    emit(InitialMapStates(currentState));
  }

  void onMapCreated({required YandexMapController yandexMapController}) async {
    var currentState = state.mapStateModel;

    currentState.controller = yandexMapController;

    final placeMarkMapObject = currentState.mapObjects
        .firstWhere((el) => el.mapId == currentState.cameraMapObjectId) as PlacemarkMapObject;

    await currentState.controller.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: placeMarkMapObject.point, zoom: 11)));

    emit(InitialMapStates(currentState));
  }

  void setAnotherPos({required CameraPosition cameraPosition}) {
    var currentState = state.mapStateModel;

    debugPrint("camera position zoom ${cameraPosition.zoom}");

    final firstMarkMapObject = currentState.mapObjects
        .firstWhere((el) => el.mapId == currentState.firstPlaceMarkId) as PlacemarkMapObject;

    final secondMarkMapObject = currentState.mapObjects
        .firstWhere((el) => el.mapId == currentState.secondPlaceMarkId) as PlacemarkMapObject;

    if (cameraPosition.zoom >= 11) {
      currentState.mapObjects[currentState.mapObjects.indexOf(firstMarkMapObject)] =
          firstMarkMapObject.copyWith(
              //38.589252 68.742095
              point: const Point(latitude: 38.589252, longitude: 68.742095));

      currentState.mapObjects[currentState.mapObjects.indexOf(secondMarkMapObject)] =
          secondMarkMapObject.copyWith(
              point: const Point(latitude: 38.548496, longitude: 68.772179));
    } else {
      currentState.mapObjects[currentState.mapObjects.indexOf(firstMarkMapObject)] =
          firstMarkMapObject.copyWith(
              point: const Point(latitude: 38.573436, longitude: 68.781747));

      currentState.mapObjects[currentState.mapObjects.indexOf(secondMarkMapObject)] =
          secondMarkMapObject.copyWith(
              point: const Point(latitude: 38.573436, longitude: 68.781747));
    }

    final placeMarkMapObject = currentState.mapObjects
        .firstWhere((el) => el.mapId == currentState.cameraMapObjectId) as PlacemarkMapObject;
    currentState.mapObjects[currentState.mapObjects.indexOf(placeMarkMapObject)] =
        placeMarkMapObject.copyWith(point: cameraPosition.target);

    emit(InitialMapStates(currentState));
  }

  //is not using
  void getPoint({required Point point}) async {
    var currentState = state.mapStateModel;

    const MapObjectId mapObjectId = MapObjectId('get_point');

    currentState.tappedPoint = PlacemarkMapObject(
        mapId: mapObjectId,
        point: point,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"), scale: 0.100)),
        opacity: 1);

    currentState.mapObjects.remove(currentState.tappedPoint);
    currentState.mapObjects.add(currentState.tappedPoint!);

    emit(InitialMapStates(currentState));
  }

  //is not using
  void requestRouts({required BuildContext context}) async {
    var currentState = state.mapStateModel;
    currentState.drivingResultWithSession = YandexDriving.requestRoutes(points: [
      RequestPoint(
          point: currentState.firstObject.point, requestPointType: RequestPointType.wayPoint),
      RequestPoint(
          point: currentState.secondObject.point, requestPointType: RequestPointType.wayPoint),
    ], drivingOptions: const DrivingOptions(initialAzimuth: 0, routesCount: 5, avoidTolls: true));

    init(result: await currentState.drivingResultWithSession?.result, context: context);
  }

  //is not using
  void init({required DrivingSessionResult? result, required BuildContext context}) async {
    var currentState = state.mapStateModel;
    if (result?.error != null) {
      print('Error: ${result?.error}');
      return;
    }
    currentState.results.add(result!);

    result.routes!.asMap().forEach((i, route) {
      currentState.mapObjects.add(PolylineMapObject(
        mapId: MapObjectId('route_${i}_polyline'),
        polyline: Polyline(points: route.geometry),
        strokeColor: Theme.of(context).colorScheme.secondary,
        strokeWidth: 3,
      ));
    });
    emit(InitialMapStates(currentState));
  }
}
