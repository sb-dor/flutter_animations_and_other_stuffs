import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/state_model/map_state_model.dart';

abstract class MainMapStates {
  MapStateModel mapStateModel;

  MainMapStates({required this.mapStateModel});
}

class InitialMapStates extends MainMapStates {
  InitialMapStates(MapStateModel mapStateModel)
      : super(mapStateModel: mapStateModel);
}
