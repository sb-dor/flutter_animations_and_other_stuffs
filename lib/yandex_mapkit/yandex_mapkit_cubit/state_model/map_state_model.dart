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
}
