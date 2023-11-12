import 'package:flutter/material.dart';
import 'package:flutter_animations_2/global_context/global_context.helper.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_states.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/state_model/map_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainMapCubit extends Cubit<MainMapStates> {
  MainMapCubit() : super(InitialMapStates(MapStateModel()));

  // if you will use function under this function comment this one
  // this function will show placeMarks while you will increase zoom, but hide while you will decrease
  void initCoordinatesFromListOfCoordinatedWithCluster() {
    var currentState = state.mapStateModel;

    List<PlacemarkMapObject> placeMarks = [];

    for (var each in currentState.listOfCoordinates) {
      MapObjectId mapId = MapObjectId('map_id_${each.lat}${each.lon}');
      placeMarks.add(PlacemarkMapObject(
          mapId: mapId,
          point: Point(latitude: each.lat, longitude: each.lon),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              anchor: const Offset(0.5, 1),
              image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
              scale: 0.100)),
          opacity: 0.5));
    }

    var cluster = ClusterizedPlacemarkCollection(
      mapId: const MapObjectId("cluster_map_id"),
      placemarks: placeMarks,
      radius: 10,
      minZoom: 15,
      // zoom where cluster will start to show
      onClusterTap: (ClusterizedPlacemarkCollection self, Cluster cluster) {
        debugPrint("on cluster tap");
      },
      onTap: (ClusterizedPlacemarkCollection self, Point point) {
        debugPrint("on tap");
      },
      // if you want to show radius of map add this one
      // onClusterAdded: (ClusterizedPlacemarkCollection self, Cluster cluster) async {
      //   return cluster.copyWith(
      //       appearance: cluster.appearance.copyWith(
      //           icon: PlacemarkIcon.single(PlacemarkIconStyle(
      //     anchor: const Offset(0.5, 1),
      //     image: BitmapDescriptor.fromAssetImage('assets/icons/cluster.png'),
      //     scale: 1,
      //   ))));
      // },
    );

    currentState.mapObjects.add(cluster);

    emit(InitialMapStates(currentState));
  }

  // if you will you function above comment this one
  void initCoordinatedFromListOfCoordinates() {
    var currentState = state.mapStateModel;

    for (var each in currentState.listOfCoordinates) {
      MapObjectId mapId = MapObjectId('map_id_${each.lat}${each.lon}');
      currentState.placeMarks.add(PlacemarkMapObject(
          mapId: mapId,
          point: Point(latitude: each.lat, longitude: each.lon),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              anchor: const Offset(0.5, 1),
              image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
              scale: 0.100)),
          opacity: 0.5));
    }

    currentState.mapObjects.addAll(currentState.placeMarks);

    emit(InitialMapStates(currentState));
  }

  //use init in first initState of map to initialize the map variables
  void initMap() {
    var currentState = state.mapStateModel;
    //initializing map objects that fade in map screen

    //main camera placeMark object that will pursue after moving camera
    currentState.cameraMapObject = PlacemarkMapObject(
        mapId: currentState.cameraMapObjectId,
        point: const Point(latitude: 38.576271, longitude: 68.779716),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            anchor: const Offset(0.5, 1),
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
            scale: 0.170)),
        opacity: 0.5);
    //38.589252 68.742095
    currentState.firstObject = PlacemarkMapObject(
        mapId: currentState.firstPlaceMarkId,
        point: const Point(latitude: 38.589252, longitude: 68.742095),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            anchor: const Offset(0.5, 1),
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
            scale: 0.100)),
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
            anchor: const Offset(0.5, 1),
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
            scale: 0.100)),
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

  //if you are searching driving routes to get information from one point to another use
  //this function. It gives all information like distance, estimated time of arrival, for adding polyLines and other things
  Future<DrivingResultWithSession?> requestRoutesBetweenPoints(
      {required Point? point1, required Point? point2}) async {
    if (point1 == null || point2 == null) return null;
    var currentState = state.mapStateModel;
    var drivingSearchResults =
        currentState.drivingResultWithSession = YandexDriving.requestRoutes(points: [
      RequestPoint(
          point: currentState.firstObject.point, requestPointType: RequestPointType.wayPoint),
      RequestPoint(
          point: currentState.secondObject.point, requestPointType: RequestPointType.wayPoint),
    ], drivingOptions: const DrivingOptions(initialAzimuth: 0, routesCount: 5, avoidTolls: true));

    return drivingSearchResults;
  }

  //for making routes to reaching the point
  void makeRoutes() async {
    var currentState = state.mapStateModel;

    var drivingRes = await requestRoutesBetweenPoints(
        point1: currentState.firstObject.point, point2: currentState.secondObject.point);

    var result = await drivingRes?.result;

    if (result?.error != null) {
      debugPrint('Error: ${result?.error}');
      return;
    }

    currentState.results.add(result!);

    currentState.searchRes = result.routes?[0].metadata.weight.distance.text;
    //this adds all possible routes to the point
    //if you want to add only one route to reach the point do it without loop and get only first object of array
    result.routes!.asMap().forEach((i, route) {
      //for getting distance and time of route
      debugPrint("$i route distance: ${route.metadata.weight.distance.text}");
      debugPrint("$i estimated time of arrival: ${route.metadata.weight.time.text}");

      currentState.mapObjects.add(PolylineMapObject(
        mapId: MapObjectId('route_${i}_polyline'),
        polyline: Polyline(points: route.geometry),
        strokeColor: Theme.of(GlobalContextHelper.globalNavigatorContext.currentContext!)
            .colorScheme
            .secondary,
        strokeWidth: 3,
      ));
    });
    emit(InitialMapStates(currentState));
  }

  // for increasing zoom
  void plusZoom() async {
    var currentState = state.mapStateModel;
    var camera = await currentState.controller.getCameraPosition();
    currentState.controller.moveCamera(CameraUpdate.zoomTo(camera.zoom + 0.3),
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 0.1));
    emit(InitialMapStates(currentState));
  }

  // for decreasing zoom
  void minusZoom() async {
    var currentState = state.mapStateModel;
    var camera = await currentState.controller.getCameraPosition();
    currentState.controller.moveCamera(CameraUpdate.zoomTo(camera.zoom - 0.3),
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 0.1));
    emit(InitialMapStates(currentState));
  }

  // while user taps on map
  void onMapTap({required Point point, required BuildContext context}) async {
    var currentState = state.mapStateModel;

    final placeMarkMapObject = currentState.mapObjects
        .firstWhere((el) => el.mapId == currentState.cameraMapObjectId) as PlacemarkMapObject;

    currentState.mapObjects[currentState.mapObjects.indexOf(placeMarkMapObject)] =
        placeMarkMapObject.copyWith(point: point);

    var cameraPos = await currentState.controller.getCameraPosition();

    var searchRes = YandexSearch.searchByPoint(
        point: point,
        zoom: cameraPos.zoom.toInt(),
        searchOptions: const SearchOptions(
          searchType: SearchType.geo,
          geometry: false,
        ));

    var res = await searchRes.result;

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${res.items?[0].name}"), duration: const Duration(milliseconds: 500)));

    emit(InitialMapStates(currentState));
  }
}
