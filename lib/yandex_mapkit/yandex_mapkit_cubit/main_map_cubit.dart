import 'package:flutter/material.dart';
import 'package:flutter_animations_2/global_context/global_context.helper.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_states.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/state_model/map_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
      placeMarks.add(
        PlacemarkMapObject(
          mapId: mapId,
          point: Point(latitude: each.lat, longitude: each.lon),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              anchor: const Offset(0.5, 1),
              image:
                  BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
              scale: 0.100)),
          opacity: 0.5,
        ),
      );
    }

    var cluster = ClusterizedPlacemarkCollection(
      mapId: const MapObjectId("cluster_map_id"),
      placemarks: placeMarks,
      radius: 10,
      // zoom where cluster will start to show
      minZoom: 15,
      onClusterTap: (ClusterizedPlacemarkCollection self, Cluster cluster) {
        debugPrint("on cluster tap");
      },
      onTap: (ClusterizedPlacemarkCollection self, Point point) {
        debugPrint("on tap");
      },
      // if you want to show circle of not shown placeMarks in map add this one
      // this will show temp position of added PlaceMarks

      onClusterAdded:
          (ClusterizedPlacemarkCollection self, Cluster cluster) async {
        return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
                icon: PlacemarkIcon.single(PlacemarkIconStyle(
          anchor: const Offset(0.5, 1),
          image: BitmapDescriptor.fromBytes(
              await currentState.buildClusterAppearance(cluster)),
          scale: 1,
        ))));
      },
    );

    currentState.mapObjects.add(cluster);

    emit(InitialMapStates(currentState));
  }

  // if you will you function above comment this one
  void initCoordinatedFromListOfCoordinates() {
    var currentState = state.mapStateModel;

    for (var each in currentState.listOfCoordinates) {
      MapObjectId mapId = MapObjectId('map_id_${each.lat}${each.lon}');
      currentState.placeMarks.add(
        PlacemarkMapObject(
          mapId: mapId,
          point: Point(latitude: each.lat, longitude: each.lon),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              anchor: const Offset(0.5, 1),
              image:
                  BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
              scale: 0.100)),
          opacity: 0.5,
        ),
      );
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
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          anchor: const Offset(0.5, 1),
          image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
          scale: 0.170,
        ),
      ),
      opacity: 0.5,
    );
    //38.589252 68.742095
    currentState.firstObject = PlacemarkMapObject(
      mapId: currentState.firstPlaceMarkId,
      point: const Point(latitude: 38.589252, longitude: 68.742095),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          anchor: const Offset(0.5, 1),
          image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
          scale: 0.100,
        ),
      ),
      opacity: 0.5,
      //if you want to do some stuff while tapping on place mark use this onTap callback
      onTap: (placeMark, point) async {
        if (currentState.loadingMap) return;
        currentState.loadingMap = true;

        //if you want to move camera use this
        await currentState.controller.moveCamera(
          CameraUpdate.newCameraPosition(
            const CameraPosition(
              target: Point(latitude: 38.589252, longitude: 68.742095),
              zoom: 13,
            ),
          ),
          animation: const MapAnimation(
            type: MapAnimationType.smooth,
            duration: 1,
          ),
        );

        currentState.loadingMap = false;
      },
    );
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
          CameraUpdate.newCameraPosition(
            const CameraPosition(
              target: Point(latitude: 38.548496, longitude: 68.772179),
              zoom: 13,
            ),
          ),
          animation: const MapAnimation(
            type: MapAnimationType.smooth,
            duration: 1,
          ),
        );

        currentState.loadingMap = false;
      },
    );

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
            .firstWhere((el) => el.mapId == currentState.cameraMapObjectId)
        as PlacemarkMapObject;

    await currentState.controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: placeMarkMapObject.point,
          zoom: 12,
        ),
      ),
    );

    emit(InitialMapStates(currentState));
  }

  //on map camera position changes
  void onCameraPositionChanged({required CameraPosition cameraPosition}) {
    var currentState = state.mapStateModel;

    debugPrint("camera position zoom ${cameraPosition.zoom}");

    debugPrint("camera position target ${cameraPosition.target}");

    final firstMarkMapObject = currentState.mapObjects
            .firstWhere((el) => el.mapId == currentState.firstPlaceMarkId)
        as PlacemarkMapObject;

    final secondMarkMapObject = currentState.mapObjects
            .firstWhere((el) => el.mapId == currentState.secondPlaceMarkId)
        as PlacemarkMapObject;

    if (cameraPosition.zoom >= 11) {
      currentState
              .mapObjects[currentState.mapObjects.indexOf(firstMarkMapObject)] =
          firstMarkMapObject.copyWith(
              //38.589252 68.742095
              point: const Point(latitude: 38.589252, longitude: 68.742095));

      currentState.mapObjects[
              currentState.mapObjects.indexOf(secondMarkMapObject)] =
          secondMarkMapObject.copyWith(
              point: const Point(latitude: 38.548496, longitude: 68.772179));
    } else {
      currentState
              .mapObjects[currentState.mapObjects.indexOf(firstMarkMapObject)] =
          firstMarkMapObject.copyWith(
              point: const Point(latitude: 38.569730, longitude: 68.755880));
      //38.569730,68.755880
      currentState.mapObjects[
              currentState.mapObjects.indexOf(secondMarkMapObject)] =
          secondMarkMapObject.copyWith(
              point: const Point(latitude: 38.569730, longitude: 68.755880));
    }

    //every time when camera moves we will move main placeMark in map after camera
    final placeMarkMapObject = currentState.mapObjects
            .firstWhere((el) => el.mapId == currentState.cameraMapObjectId)
        as PlacemarkMapObject;
    currentState
            .mapObjects[currentState.mapObjects.indexOf(placeMarkMapObject)] =
        placeMarkMapObject.copyWith(point: cameraPosition.target);

    emit(InitialMapStates(currentState));
  }

  //searching by point that user clicks
  void searchByPoint({required BuildContext context}) async {
    var currentState = state.mapStateModel;
    final getCameraPosition = await currentState.controller.getCameraPosition();

    var results = await YandexSearch.searchByPoint(
      point: getCameraPosition.target,
      zoom: getCameraPosition.zoom.toInt(),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );

    SearchSessionResult searchResult = await results.$2;
    if (searchResult.error != null) {
      //any error message or function
      return;
    }
    debugPrint("name: ${searchResult.items}");
    debugPrint("name: ${searchResult.items?[0].name}");
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${searchResult.items?[0].name}",
          ),
        ),
      );
    }
  }

  //searching by text
  void searchByText({required BuildContext context}) async {
    var currentState = state.mapStateModel;

    var cameraPosition = await currentState.controller.getCameraPosition();

    final results = await YandexSearch.searchByText(
      searchText: currentState.searchByNameController.text.trim(),
      geometry: Geometry.fromBoundingBox(BoundingBox(
        southWest: Point(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude),
        northEast: Point(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude),
      )),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );

    SearchSessionResult result = await results.$2;

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
            image: BitmapDescriptor.fromAssetImage("assets/icons/map_icon.png"),
            scale: 0.100)),
        opacity: 1);

    currentState.mapObjects.remove(currentState.tappedPoint);
    currentState.mapObjects.add(currentState.tappedPoint!);

    emit(InitialMapStates(currentState));
  }

  //if you are searching driving routes to get information from one point to another use
  //this function. It gives all information like distance, estimated time of arrival, for adding polyLines and other things
  Future<DrivingSessionResult?> requestRoutesBetweenPoints(
      {required Point? point1, required Point? point2}) async {
    if (point1 == null || point2 == null) return null;
    var currentState = state.mapStateModel;
    var drivingSearchResults = await YandexDriving.requestRoutes(
        points: [
          RequestPoint(
              point: currentState.firstObject.point,
              requestPointType: RequestPointType.wayPoint),
          RequestPoint(
              point: currentState.secondObject.point,
              requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: const DrivingOptions(
            initialAzimuth: 0, routesCount: 5, avoidTolls: true));

    currentState.drivingResultWithSession = await drivingSearchResults.$2;

    return drivingSearchResults.$2;
  }

  //for making routes to reaching the point
  void makeRoutes() async {
    var currentState = state.mapStateModel;

    var drivingRes = await requestRoutesBetweenPoints(
        point1: currentState.firstObject.point,
        point2: currentState.secondObject.point);

    if (drivingRes?.error != null) {
      debugPrint('Error: ${drivingRes?.error}');
      return;
    }

    currentState.results.add(drivingRes!);

    currentState.searchRes =
        drivingRes.routes?[0].metadata.weight.distance.text;
    //this adds all possible routes to the point
    //if you want to add only one route to reach the point do it without loop and get only first object of array
    drivingRes.routes!.asMap().forEach((i, route) {
      //for getting distance and time of route
      debugPrint("$i route distance: ${route.metadata.weight.distance.text}");
      debugPrint(
          "$i estimated time of arrival: ${route.metadata.weight.time.text}");

      currentState.mapObjects.add(PolylineMapObject(
        mapId: MapObjectId('route_${i}_polyline'),
        polyline: Polyline(points: route.geometry.points),
        strokeColor: Theme.of(GlobalContextHelper
                .instance.globalNavigatorContext.currentContext!)
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
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.1));
    emit(InitialMapStates(currentState));
  }

  // for decreasing zoom
  void minusZoom() async {
    var currentState = state.mapStateModel;
    var camera = await currentState.controller.getCameraPosition();
    currentState.controller.moveCamera(CameraUpdate.zoomTo(camera.zoom - 0.3),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.1));
    emit(InitialMapStates(currentState));
  }

  // while user taps on map
  void onMapTap({required Point point, required BuildContext context}) async {
    var currentState = state.mapStateModel;

    final placeMarkMapObject = currentState.mapObjects
            .firstWhere((el) => el.mapId == currentState.cameraMapObjectId)
        as PlacemarkMapObject;

    currentState
            .mapObjects[currentState.mapObjects.indexOf(placeMarkMapObject)] =
        placeMarkMapObject.copyWith(point: point);

    var cameraPos = await currentState.controller.getCameraPosition();

    currentState.controller.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          target: point,
          zoom: cameraPos.zoom,
          azimuth: cameraPos.azimuth,
          tilt: cameraPos.tilt)),
      animation:
          const MapAnimation(type: MapAnimationType.smooth, duration: 0.3),
    );

    var searchRes = await YandexSearch.searchByPoint(
        point: point,
        zoom: cameraPos.zoom.toInt(),
        searchOptions: const SearchOptions(
          searchType: SearchType.geo,
          geometry: false,
        ));

    var res = await searchRes.$2;

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${res.items?[0].name}"),
        duration: const Duration(milliseconds: 500)));

    suggestPositionsInRequest(res.items?[0].name);

    emit(InitialMapStates(currentState));
  }

  // while use clicks on any object on the map, the object will be blue color
  void onObjectTap({required GeoObject geoObject}) async {
    var currentState = state.mapStateModel;

    // debugPrint(
    //     "object geometry: ${geoObject.geometry}"); // gives us a Geometry object where point is there
    // debugPrint("object name: ${geoObject.name}");
    // debugPrint("selecting metadata id: ${geoObject.selectionMetadata?.id}");
    // debugPrint("object geometry[0]: ${geoObject.geometry[0]}");
    // debugPrint("object geometry[1]: ${geoObject.geometry[1]}");

    if (geoObject.selectionMetadata != null) {
      currentState.controller.selectGeoObject(
        objectId: geoObject.selectionMetadata!.objectId,
        layerId: geoObject.selectionMetadata!.layerId,
        dataSourceName: geoObject.selectionMetadata!.dataSourceName,
      );

      // for deselecting object on map
      // currentState.controller.deselectGeoObject();
    }
  }

  // changing map type, vector is normal type of yandexMap that we use
  void changeMapType({required MapType mapType}) {
    var currentState = state.mapStateModel;

    currentState.mapType = mapType;

    emit(InitialMapStates(currentState));
  }

  void addCircleMapObject() {
    var currentState = state.mapStateModel;

    if (currentState.mapObjects.any((element) =>
        element.mapId == const MapObjectId('circle_map_object_id-1'))) {
      currentState.mapObjects.removeWhere((element) =>
          element.mapId == const MapObjectId('circle_map_object_id-1'));
      emit(InitialMapStates(currentState));
      return;
    }

    final mapObject = CircleMapObject(
      mapId: const MapObjectId('circle_map_object_id-1'),
      circle: const Circle(
          center: Point(latitude: 38.583026, longitude: 68.716816),
          radius: 1000),
      strokeColor: Colors.blue[700]!,
      fillColor: Colors.blue[300]!.withValues(alpha: 0.3),
      onTap: (CircleMapObject self, Point point) =>
          debugPrint('Tapped me at $point'),
    );

    debugPrint("radius : ${mapObject.circle.radius}");

    currentState.mapObjects.add(mapObject);

    emit(InitialMapStates(currentState));
  }

  void addPolygonPlacesInMap() {
    var currentState = state.mapStateModel;

    if (currentState.mapObjects.any((element) =>
        element.mapId == const MapObjectId('polygon_map_object_id-1'))) {
      currentState.mapObjects.removeWhere((element) =>
          element.mapId == const MapObjectId('polygon_map_object_id-1'));
      emit(InitialMapStates(currentState));
      return;
    }

    //this function adds polygons like dodoPizza shows that the order cannot be ordered outside the drawn border
    var polygonMapObject = PolygonMapObject(
        strokeColor: Colors.orange[700]!,
        strokeWidth: 3.0,
        fillColor: Colors.yellow[200]!.withValues(alpha: 0.4),
        onTap: (PolygonMapObject self, Point point) =>
            debugPrint('Tapped me at $point'),
        mapId: const MapObjectId("polygon_map_object_id-1"),
        polygon: const Polygon(
            outerRing: LinearRing(points: [
              Point(latitude: 38.613058, longitude: 68.770464),
              Point(latitude: 38.560157, longitude: 68.706866),
              Point(latitude: 38.496407, longitude: 68.758543),
              Point(latitude: 38.563542, longitude: 68.818047),
            ]),
            innerRings: [
              // LinearRing(points: [
              //   Point(latitude: 38.583058, longitude: 68.740464),
              //   Point(latitude: 38.556157, longitude: 68.726866),
              //   Point(latitude: 38.516407, longitude: 68.748543),
              // ])
            ]));

    currentState.mapObjects.add(polygonMapObject);

    emit(InitialMapStates(currentState));
  }

  // when user search some address this function will suggest him other same addresses
  void suggestPositionsInRequest(String? addressName) async {
    final resultWithSession = await YandexSuggest.getSuggestions(
        text: addressName ?? "микрорайон Зарафшон, 1м3",
        boundingBox: const BoundingBox(
            northEast: Point(latitude: 56.0421, longitude: 38.0284),
            southWest: Point(latitude: 55.5143, longitude: 37.24841)),
        suggestOptions: const SuggestOptions(
          suggestType: SuggestType.geo,
          suggestWords: true,
        ));

    var res = await resultWithSession.$2;

    for (var each in res.items ?? <SuggestItem>[]) {
      debugPrint("title: ${each.title}");
      debugPrint("subtitle: ${each.subtitle}");
      debugPrint("displayText: ${each.displayText}");
      debugPrint("searchText: ${each.searchText}");
    }

    List<SuggestItem> suggests = (res.items ?? [])
        .where((element) => element.subtitle == "Душанбе")
        .toList();

    debugPrint("suggests list : ${suggests.length}");
  }

  //

  void _clearDestinationsMarks() {
    var currentState = state.mapStateModel;
    currentState.mapObjects.removeWhere(
      (element) =>
          element.mapId.value == 'destination_1' ||
          element.mapId.value == 'destination_2' ||
          element.mapId.value == 'destination',
    );
    currentState.polyLineDestinationIds = 0;
  }

  void startToSelectDestination() {
    var currentState = state.mapStateModel;
    currentState.selectingUserDestination =
        !currentState.selectingUserDestination;
    if (currentState.selectingUserDestination) _clearDestinationsMarks();
    emit(InitialMapStates(currentState));
  }

  void addTwoPolyLinesBetweenTwoDestinations(Point point) async {
    var currentState = state.mapStateModel;

    currentState.polyLineDestinationIds++;

    MapObjectId firstPlaceMarkId =
        MapObjectId('destination_${currentState.polyLineDestinationIds}');

    PlacemarkMapObject marker =
        PlacemarkMapObject(mapId: firstPlaceMarkId, point: point);

    currentState.mapObjects.add(marker);

    final PlacemarkMapObject? firstMarker = currentState.mapObjects
            .firstWhereOrNull(
                (element) => element.mapId.value == 'destination_1')
        as PlacemarkMapObject?;

    final PlacemarkMapObject? secondMarker = currentState.mapObjects
            .firstWhereOrNull(
                (element) => element.mapId.value == 'destination_2')
        as PlacemarkMapObject?;

    debugPrint("first: ${firstMarker?.point} | second: ${secondMarker?.point}");

    if (firstMarker != null && secondMarker != null) {
      final yandexSearch = await YandexDriving.requestRoutes(
        points: [
          RequestPoint(
              point: firstMarker.point,
              requestPointType: RequestPointType.wayPoint),
          RequestPoint(
              point: secondMarker.point,
              requestPointType: RequestPointType.wayPoint)
        ],
        drivingOptions: const DrivingOptions(
            initialAzimuth: 0, routesCount: 5, avoidTolls: true),
      );

      final result = await yandexSearch.$2;

      const MapObjectId placeMark = MapObjectId('destination');

      final getPos = PolylineMapObject(
        mapId: placeMark,
        polyline: Polyline(
            points: (result.routes ?? <DrivingRoute>[]).first.geometry.points),
        strokeColor: Theme.of(GlobalContextHelper
                .instance.globalNavigatorContext.currentContext!)
            .colorScheme
            .secondary,
        strokeWidth: 3,
      );

      currentState.selectingUserDestination = false;
      currentState.mapObjects.add(getPos);
    }
    emit(InitialMapStates(currentState));
  }

  // for finding address through drawing points in screen
  // from "Яндекс недвижимость"
  void getPointFromScreenPosition(Offset screenPositionOffset) async {
    var currentState = state.mapStateModel;

    currentState.searchingPlaces.add(
      Positioned(
        left: screenPositionOffset.dx,
        top: screenPositionOffset.dy,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );

    var screenPoint =
        ScreenPoint(x: screenPositionOffset.dx, y: screenPositionOffset.dy);

    // add this point to the list and make request with this points in server
    var point = await currentState.controller.getPoint(screenPoint);

    emit(InitialMapStates(currentState));

    debugPrint("point is : $point");
  }

  void clearSavedPoints() {
    var currentState = state.mapStateModel;

    currentState.searchingPlaces.clear();
    currentState.searchingPoints.clear();

    emit(InitialMapStates(currentState));
  }
}
