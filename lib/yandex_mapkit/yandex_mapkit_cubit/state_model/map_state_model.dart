import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapStateModel {
  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placeMark');
  final MapObjectId firstPlaceMarkId = const MapObjectId('first_place_mark_id');
  final MapObjectId secondPlaceMarkId = const MapObjectId('second_place_mark_id');

  DrivingResultWithSession? drivingResultWithSession;

  final List<DrivingSessionResult> results = [];

  GlobalKey mapKey = GlobalKey();

  PlacemarkMapObject? tappedPoint;

  late final PlacemarkMapObject cameraMapObject;
  late final PlacemarkMapObject firstObject;
  late final PlacemarkMapObject secondObject;

  late YandexMapController controller;

  late final List<MapObject> mapObjects;

  bool loadingMap = false;

}
