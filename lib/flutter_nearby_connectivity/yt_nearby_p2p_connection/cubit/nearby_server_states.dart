import 'state_model/nearby_server_state_model.dart';

abstract class NearbyServerStates {
  NearbyServerStateModel nearbyServerStateModel;

  NearbyServerStates({required this.nearbyServerStateModel});
}

class InitialNearbyServerState extends NearbyServerStates {
  InitialNearbyServerState(NearbyServerStateModel nearbyServerStateModel)
      : super(nearbyServerStateModel: nearbyServerStateModel);
}
