import 'package:flutter/material.dart';
import 'package:flutter_animations_2/app_light_and_dark_theme/app_light_and_dark_theme.dart';
import 'package:flutter_animations_2/bottom_modal_sheet_dynamic_size/bottom_modal_sheet_dynamic_size.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_cubit.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapScreen extends StatelessWidget {
  const YandexMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<MainMapCubit, MainMapStates>(builder: (context, mapState) {
      var currentState = mapState.mapStateModel;
      return Scaffold(
          floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
                child: Container(
              height: 50,
              color: Colors.grey.withOpacity(0.4),
              child: TextField(
                controller: currentState.searchByNameController,
                onEditingComplete: () =>
                    context.read<MainMapCubit>().searchByText(context: context),
              ),
            )),
            FloatingActionButton(
                onPressed: () async => BottomModalSheetDynamicSize.bottomSheet(context: context),
                child: const Icon(Icons.location_city)),
            FloatingActionButton(
                onPressed: () async => context.read<MainMapCubit>().searchByPoint(context: context),
                child: const Icon(Icons.search))
          ]),
          body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: mapHeight,
              child: YandexMap(
                  key: currentState.mapKey,
                  nightModeEnabled: AppTheme.checkDarkMode(context: context),
                  // key: mapObjects,
                  mapObjects: currentState.mapObjects,
                  mapMode: MapMode.normal,
                  logoAlignment: const MapAlignment(
                      vertical: VerticalAlignment.top, horizontal: HorizontalAlignment.left),
                  onCameraPositionChanged:
                      (CameraPosition cameraPosition, CameraUpdateReason _, bool __) async {
                    context
                        .read<MainMapCubit>()
                        .onCameraPositionChanged(cameraPosition: cameraPosition);
                  },
                  // onMapTap: (Point point) => context.read<MainMapCubit>().getPoint(point: point),
                  onObjectTap: (object) {
                    debugPrint("object tapping");
                  },
                  onTrafficChanged: (TrafficLevel? trafficLevel) => [],
                  onMapCreated: (YandexMapController yandexMapController) async => context
                      .read<MainMapCubit>()
                      .onMapCreated(yandexMapController: yandexMapController),
                  onUserLocationAdded: (UserLocationView view) async {
                    return view.copyWith(
                        pin: view.pin.copyWith(
                            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                image:
                                    BitmapDescriptor.fromAssetImage('assets/icons/map_icon.png')))),
                        arrow: view.arrow.copyWith(
                            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                                image:
                                    BitmapDescriptor.fromAssetImage('assets/icons/map_icon.png')))),
                        accuracyCircle:
                            view.accuracyCircle.copyWith(fillColor: Theme.of(context).cardColor));
                  })));
    });
  }
}
