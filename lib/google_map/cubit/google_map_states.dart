import 'package:flutter_animations_2/google_map/cubit/state_model/google_map_state_model.dart';

abstract class GoogleMapStates {
  GoogleMapStateModel googleMapStateModel;

  GoogleMapStates({required this.googleMapStateModel});
}

class InitialGoogleMapState extends GoogleMapStates {
  InitialGoogleMapState(GoogleMapStateModel googleMapStateModel)
      : super(googleMapStateModel: googleMapStateModel);
}
