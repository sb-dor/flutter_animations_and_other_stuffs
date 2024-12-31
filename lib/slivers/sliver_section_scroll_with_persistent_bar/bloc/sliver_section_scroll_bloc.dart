import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sliver_section_scroll_bloc.freezed.dart';

@freezed
class SliverSectionScrollEvent with _$SliverSectionScrollEvent {
  const factory SliverSectionScrollEvent.init() = _InitialEventOnSliverSectionScrollEvent;

  const factory SliverSectionScrollEvent.initPosition() =
      _InitPositionEventOnSliverSectionScrollEvent;

  const factory SliverSectionScrollEvent.scrollListener() =
      _ScrollListenerOnSliverSectionScrollEvent;

  const factory SliverSectionScrollEvent.animateTabBarOnScroll() =
      _AnimateTabBarOnScrollEventonSliverSectionScrollEvent;
}

@freezed
sealed class SliverSectionScrollState with _$SliverSectionScrollState {
  const factory SliverSectionScrollState.initial() = InitialStateOnSliverSectionScrollState;

  const factory SliverSectionScrollState.inProgress() = InProgressStateOnSliverSectionScrollState;

  const factory SliverSectionScrollState.initializingPositionsState() = InitializingPositionsState;

  const factory SliverSectionScrollState.completedState() =
      CompletedStateOnSliverSectionScrollState;
}

class SliverSectionScrollBloc extends Bloc<SliverSectionScrollEvent, SliverSectionScrollState> {
  SliverSectionScrollBloc() : super(const SliverSectionScrollState.initial()) {
    //
    on<SliverSectionScrollEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
