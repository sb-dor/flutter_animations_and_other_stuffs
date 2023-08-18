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

    //main camera placeMark object that will pursue after moving camera
    currentState.cameraMapObject = PlacemarkMapObject(
        mapId: currentState.cameraMapObjectId,
        point: const Point(latitude: 38.576271, longitude: 68.779716),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"), scale: 0.170)),
        opacity: 0.5);
    //38.589252 68.742095
    currentState.firstObject = PlacemarkMapObject(
        mapId: currentState.firstPlaceMarkId,
        point: const Point(latitude: 38.589252, longitude: 68.742095),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"), scale: 0.100)),
        opacity: 0.5,
        //if you want to do some stuff while tapping on place mark use this onTap callback
        onTap: (placeMark, point) async {
          if (currentState.loadingMap) return;
          currentState.loadingMap = true;

          //if you want to move camera use this
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
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"), scale: 0.100)),
        opacity: 0.5,
        //if you want to do some stuff while tapping on place mark use this onTap callback
        onTap: (placeMark, point) async {
          if (currentState.loadingMap) return;
          currentState.loadingMap = true;

          //if you want to move camera use this
          await currentState.controller.moveCamera(
              CameraUpdate.newCameraPosition(const CameraPosition(
                  target: Point(latitude: 38.548496, longitude: 68.772179), zoom: 13)),
              animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1));

          currentState.loadingMap = false;
        });

    //add all placeMarkObject here. This mapObject will be added in YandexMap widget in YandexMapScreen
    currentState.mapObjects = [
      currentState.cameraMapObject,
      currentState.firstObject,
      currentState.secondObject
    ];
    emit(InitialMapStates(currentState));
  }

  //use this void as map created. Necessary function for mapController and start position for camera
  void onMapCreated({required YandexMapController yandexMapController}) async {
    var currentState = state.mapStateModel;

    currentState.controller = yandexMapController;

    final placeMarkMapObject = currentState.mapObjects
        .firstWhere((el) => el.mapId == currentState.cameraMapObjectId) as PlacemarkMapObject;

    await currentState.controller.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: placeMarkMapObject.point, zoom: 11)));

    emit(InitialMapStates(currentState));
  }

  //on map camera position changes
  void onCameraPositionChanged({required CameraPosition cameraPosition}) {
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
              point: const Point(latitude: 38.569730, longitude: 68.755880));
      //38.569730,68.755880
      currentState.mapObjects[currentState.mapObjects.indexOf(secondMarkMapObject)] =
          secondMarkMapObject.copyWith(
              point: const Point(latitude: 38.569730, longitude: 68.755880));
    }

    //every time when camera moves we will move main placeMark in map after camera
    final placeMarkMapObject = currentState.mapObjects
        .firstWhere((el) => el.mapId == currentState.cameraMapObjectId) as PlacemarkMapObject;
    currentState.mapObjects[currentState.mapObjects.indexOf(placeMarkMapObject)] =
        placeMarkMapObject.copyWith(point: cameraPosition.target);

    emit(InitialMapStates(currentState));
  }

  //searching by point that user clicks
  void searchByPoint({required BuildContext context}) async {
    var currentState = state.mapStateModel;
    final getCameraPosition = await currentState.controller.getCameraPosition();

    var results = YandexSearch.searchByPoint(
        point: getCameraPosition.target,
        zoom: getCameraPosition.zoom.toInt(),
        searchOptions: const SearchOptions(searchType: SearchType.geo, geometry: false));

    SearchSessionResult searchResult = await results.result;
    if (searchResult.error != null) {
      //any error message or function
      return;
    }
    debugPrint("name: ${searchResult.items}");
    debugPrint("name: ${searchResult.items?[0].name}");
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${searchResult.items?[0].name}")));
    }
  }

  //searching by text
  void searchByText({required BuildContext context}) async {
    var currentState = state.mapStateModel;

    var cameraPosition = await currentState.controller.getCameraPosition();

    final results = YandexSearch.searchByText(
        searchText: currentState.searchByNameController.text.trim(),
        geometry: Geometry.fromBoundingBox(BoundingBox(
          southWest: Point(
              latitude: cameraPosition.target.latitude, longitude: cameraPosition.target.longitude),
          northEast: Point(
              latitude: cameraPosition.target.latitude, longitude: cameraPosition.target.longitude),
        )),
        searchOptions: const SearchOptions(searchType: SearchType.geo, geometry: false));
    SearchSessionResult result = await results.result;

    if (result.error != null) {
      //any error message or function
      return;
    }
    List<Widget> resultsWidgets = [];
    for (var each in result.items ?? <SearchItem>[]) {
      resultsWidgets.add(Text(each.name));
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Column(children: resultsWidgets)));
    }
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
