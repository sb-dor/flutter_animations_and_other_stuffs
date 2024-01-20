import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapStateModel {
  //
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int lastMarkerId = 1;

  //
  late GoogleMapController controller;
}
