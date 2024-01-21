import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapStateModel {
  //
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int lastMarkerId = 1;

  //
  Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};

  //
  late GoogleMapController controller;

  Location location = Location();

  bool serviceEnabled = false, selectingUserDestination = false;

  PermissionStatus? status;

  int polyLineDestinationIds = 0;
}
