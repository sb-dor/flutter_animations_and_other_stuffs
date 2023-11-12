import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapStateModel {
  //create unique id for all placeMarks
  final MapObjectId firstPlaceMarkId = const MapObjectId('first_place_mark_id');
  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placeMark');
  final MapObjectId secondPlaceMarkId = const MapObjectId('second_place_mark_id');

  DrivingResultWithSession? drivingResultWithSession;

  final List<DrivingSessionResult> results = [];

  GlobalKey mapKey = GlobalKey();

  //if you want to tap on map end get the place use this variable
  PlacemarkMapObject? tappedPoint;

  //all place marks that will be initialized and use as a place marks in map screen
  late final PlacemarkMapObject cameraMapObject;
  late final PlacemarkMapObject firstObject;
  late final PlacemarkMapObject secondObject;

  //main controller for map
  late YandexMapController controller;

  //search controller
  TextEditingController searchByNameController = TextEditingController(text: '');

  //all placeMarks after initializing will be added here
  late final List<MapObject> mapObjects;

  bool loadingMap = false;

  String? searchRes;

  //whenever you have coordinates you should have placeMarkObject and MapObjectId for each of them
  List<Coordinate> listOfCoordinates = [
    Coordinate(lat: 38.565559, lon: 68.760942),
    Coordinate(lat: 38.567230, lon: 68.761265),
    Coordinate(lat: 38.565714, lon: 68.753998),
    Coordinate(lat: 38.568126, lon: 68.760241),
  ];

  // after initialing placeMarks you should add this list's objects to "mapObjects"
  List<PlacemarkMapObject> placeMarks = [];

  ScreenRect? focusRect;
}

class Coordinate {
  double lat;
  double lon;

  Coordinate({required this.lat, required this.lon});
}
