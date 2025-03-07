import 'package:flutter/material.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_cubit.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetLatLotByScreenDrawingScreen extends StatelessWidget {
  const GetLatLotByScreenDrawingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainMapCubit, MainMapStates>(builder: (context, state) {
      var currentState = state.mapStateModel;
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: Listener(
                onPointerMove: (PointerMoveEvent move) {
                  context.read<MainMapCubit>().getPointFromScreenPosition(move.position);
                },
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: currentState.searchingPlaces,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
