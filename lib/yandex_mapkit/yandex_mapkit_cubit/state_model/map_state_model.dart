import 'dart:ui';

import 'package:flutter/foundation.dart';
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
    Coordinate(lat: 38.566151, lon: 68.765235),
    Coordinate(lat: 38.568133, lon: 68.756118),
    Coordinate(lat: 38.563697, lon: 68.758866),
    Coordinate(lat: 38.567209, lon: 68.757178),
    Coordinate(lat: 38.568175, lon: 68.762046),
    Coordinate(lat: 38.567244, lon: 68.764005),
  ];

  // after initialing placeMarks you should add this list's objects to "mapObjects"
  List<PlacemarkMapObject> placeMarks = [];

  MapType mapType = MapType.vector;

  // this is image for ClusterizedPlacemark
  // this will create a circle and number of not shown placemarks in it
  Future<Uint8List> buildClusterAppearance(Cluster cluster) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(200, 200);
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    const radius = 60.0;

    final textPainter = TextPainter(
        text: TextSpan(
            text: cluster.size.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 50)),
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset =
        Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2);
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }
}

class Coordinate {
  double lat;
  double lon;

  Coordinate({required this.lat, required this.lon});
}
