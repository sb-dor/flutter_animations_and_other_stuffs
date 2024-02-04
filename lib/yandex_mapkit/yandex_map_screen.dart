import 'package:flutter/material.dart';
import 'package:flutter_animations_2/app_light_and_dark_theme/app_light_and_dark_theme.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheet_dynamic_size.dart';
import 'package:flutter_animations_2/yandex_mapkit/get_lat_lot_by_screen_drawing_screen.dart';
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    ElevatedButton.icon(
                        onPressed: () => context.read<MainMapCubit>().addPolygonPlacesInMap(),
                        icon: const Icon(Icons.policy),
                        label: const Text("polygon")),
                    ElevatedButton.icon(
                        onPressed: () =>
                            context.read<MainMapCubit>().suggestPositionsInRequest(null),
                        icon: const Icon(Icons.settings_suggest),
                        label: const Text("suggest address")),
                  ]),
                ),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    if (!currentState.selectingUserDestination)
                      ElevatedButton.icon(
                          onPressed: () => context.read<MainMapCubit>().startToSelectDestination(),
                          icon: const Icon(Icons.policy),
                          label: const Text("Polyline Two")),
                    ElevatedButton.icon(
                        onPressed: () async => await showDialog(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => GetLatLotByScreenDrawingScreen())
                                .then((value) {
                              context.read<MainMapCubit>().clearSavedPoints();
                            }),
                        icon: const Icon(Icons.policy),
                        label: const Text("Get Position by screen")),
                  ]),
                )
              ]),
              Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ElevatedButton.icon(
                      onPressed: () => context.read<MainMapCubit>().plusZoom(),
                      icon: const Icon(Icons.add),
                      label: const Text("Zoom")),
                  ElevatedButton.icon(
                      onPressed: () => context.read<MainMapCubit>().minusZoom(),
                      icon: const Icon(Icons.remove),
                      label: const Text("Zoom")),
                ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent.shade100,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(10),
                            child: const Row(children: [Icon(Icons.map), Text("Change Map Type")]),
                          ),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    onTap: () => context
                                        .read<MainMapCubit>()
                                        .changeMapType(mapType: MapType.none),
                                    child: const Text("None")),
                                PopupMenuItem(
                                    onTap: () => context
                                        .read<MainMapCubit>()
                                        .changeMapType(mapType: MapType.hybrid),
                                    child: const Text("hybrid")),
                                PopupMenuItem(
                                    onTap: () => context
                                        .read<MainMapCubit>()
                                        .changeMapType(mapType: MapType.map),
                                    child: const Text("map")),
                                PopupMenuItem(
                                    onTap: () => context
                                        .read<MainMapCubit>()
                                        .changeMapType(mapType: MapType.satellite),
                                    child: const Text("satellite")),
                                PopupMenuItem(
                                    onTap: () => context
                                        .read<MainMapCubit>()
                                        .changeMapType(mapType: MapType.vector),
                                    child: const Text("vector"))
                              ]),
                      ElevatedButton.icon(
                          onPressed: () => context.read<MainMapCubit>().addCircleMapObject(),
                          icon: Icon(Icons.circle),
                          label: Text("Add circle map object"))
                    ])
              ]),
              if (currentState.searchRes != null)
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        color: Colors.white,
                        width: 150,
                        height: 40,
                        child: Center(child: Text("${currentState.searchRes}")))),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                    onPressed: () async => context.read<MainMapCubit>().makeRoutes(),
                    child: const Icon(Icons.route, color: Colors.white)),
                const SizedBox(width: 10),
                FloatingActionButton(
                    onPressed: () async =>
                        BottomModalSheetDynamicSize.bottomSheetWithSizeOfContent(context: context),
                    child: const Icon(Icons.location_city, color: Colors.white)),
                const SizedBox(width: 10),
                FloatingActionButton(
                    onPressed: () async =>
                        context.read<MainMapCubit>().searchByPoint(context: context),
                    child: const Icon(Icons.search, color: Colors.white))
              ]),
            ],
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: mapHeight,
          child: YandexMap(
            key: currentState.mapKey,
            nightModeEnabled: AppTheme.checkDarkMode(context: context),
            // key: mapObjects,
            mapObjects: currentState.mapObjects,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            mapMode: MapMode.normal,
            mapType: currentState.mapType,
            logoAlignment: const MapAlignment(
                vertical: VerticalAlignment.top, horizontal: HorizontalAlignment.left),
            onCameraPositionChanged:
                (CameraPosition cameraPosition, CameraUpdateReason _, bool __) async {
              context.read<MainMapCubit>().onCameraPositionChanged(cameraPosition: cameraPosition);
            },
            // onMapTap: (Point point) => context.read<MainMapCubit>().getPoint(point: point),
            onObjectTap: (object) {
              context.read<MainMapCubit>().onObjectTap(geoObject: object);
            },
            // if you want to search your location use this one
            onMapTap: (Point point) => currentState.selectingUserDestination
                ? context.read<MainMapCubit>().addTwoPolyLinesBetweenTwoDestinations(point)
                : context.read<MainMapCubit>().onMapTap(point: point, context: context),
            onTrafficChanged: (TrafficLevel? trafficLevel) => [],
            onMapCreated: (YandexMapController yandexMapController) async =>
                context.read<MainMapCubit>().onMapCreated(yandexMapController: yandexMapController),
            onUserLocationAdded: (UserLocationView view) async {
              return view.copyWith(
                  pin: view.pin.copyWith(
                      icon: PlacemarkIcon.single(PlacemarkIconStyle(
                          image: BitmapDescriptor.fromAssetImage('assets/icons/map_icon.png')))),
                  arrow: view.arrow.copyWith(
                      icon: PlacemarkIcon.single(PlacemarkIconStyle(
                          image: BitmapDescriptor.fromAssetImage('assets/icons/map_icon.png')))),
                  accuracyCircle:
                      view.accuracyCircle.copyWith(fillColor: Theme.of(context).cardColor));
            },
          ),
        ),
      );
    });
  }
}
