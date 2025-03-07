import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/bloc/state_model/sliver_section_scroll_state_model.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/models/sliver_category_model.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/models/sliver_product_model.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/widgets/tabbar/sliver_section_scroll_tabbar_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'sliver_section_scroll_bloc.freezed.dart';

@freezed
class SliverSectionScrollEvent with _$SliverSectionScrollEvent {
  const factory SliverSectionScrollEvent.init() =
      _InitialEventOnSliverSectionScrollEvent;

  const factory SliverSectionScrollEvent.initPosition({
    required Future<void> Function() animateToLastPosition,
  }) = _InitPositionEventOnSliverSectionScrollEvent;

  const factory SliverSectionScrollEvent.scrollListener({
    required final ScrollController listScrollController,
    required final ItemScrollController tabBarScrollController,
    required final double middleOfTheScreen,
  }) = _ScrollListenerOnSliverSectionScrollEvent;

  const factory SliverSectionScrollEvent.animateTabBarOnScroll({
    required final int position,
    required final ItemScrollController tabBarScrollController,
  }) = _AnimateTabBarOnScrollEventonSliverSectionScrollEvent;

  const factory SliverSectionScrollEvent.animateToPositionOnClick({
    required int indexPosition,
    required ScrollController listScrollController,
  }) = _AnimateToPositionOnClick;
}

@freezed
sealed class SliverSectionScrollState with _$SliverSectionScrollState {
  const SliverSectionScrollState._();

  //
  bool get isInProgress =>
      maybeMap(orElse: () => false, inProgress: (_) => true);

  //
  const factory SliverSectionScrollState.initial(
          SliverSectionScrollStateModel stateModel) =
      InitialStateOnSliverSectionScrollState;

  const factory SliverSectionScrollState.inProgress(
          SliverSectionScrollStateModel stateModel) =
      InProgressStateOnSliverSectionScrollState;

  const factory SliverSectionScrollState.initializingPositionsState(
          SliverSectionScrollStateModel stateModel) =
      InitializingPositionsStateOnSliverSectionScrollState;

  const factory SliverSectionScrollState.completedState(
          SliverSectionScrollStateModel stateModel) =
      CompletedStateOnSliverSectionScrollState;
}

class SliverSectionScrollBloc
    extends Bloc<SliverSectionScrollEvent, SliverSectionScrollState> {
  SliverSectionScrollBloc()
      : super(SliverSectionScrollState.initial(
            SliverSectionScrollStateModel.idle())) {
    //
    on<SliverSectionScrollEvent>(
      (event, emit) => event.map(
        init: (event) => _init(event, emit),
        initPosition: (event) => _initPositions(event, emit),
        scrollListener: (event) => _scrollListener(event, emit),
        animateTabBarOnScroll: (event) => _animateToTabBarOnScroll(event, emit),
        animateToPositionOnClick: (event) =>
            _animateToPositionOnClick(event, emit),
      ),
    );
  }

  void _init(
    _InitialEventOnSliverSectionScrollEvent event,
    Emitter<SliverSectionScrollState> emit,
  ) async {
    emit(SliverSectionScrollState.inProgress(
        SliverSectionScrollStateModel.idle()));

    await Future.delayed(const Duration(seconds: 5));

    List<SliverCategoryModel> categories = [];

    // create test categories
    for (int i = 1; i <= 15; i++) {
      List<SliverProductModel> products = [];
      for (int j = 1; j <= 10; j++) {
        products.add(SliverProductModel(
          id: j,
          name: "Product $j of Category $i",
        ));
      }

      categories.add(SliverCategoryModel(
        id: i,
        name: "Category $i",
        products: products,
      ));
    }

    var currentStateModel = state.stateModel.copyWith(
      categories: categories,
    );

    for (final each in currentStateModel.categories) {
      List<GlobalKey> globalKeys =
          List<GlobalKey>.from(currentStateModel.globalKeys);
      List<String> sliverTitles =
          List<String>.from(currentStateModel.sliverTitles);

      globalKeys.add(GlobalKey());
      sliverTitles.add(each.name ?? '-');
      currentStateModel = currentStateModel.copyWith(
        globalKeys: globalKeys,
        sliverTitles: sliverTitles,
      );
    }

    emit(
        SliverSectionScrollState.initializingPositionsState(currentStateModel));
  }

  void _initPositions(
    _InitPositionEventOnSliverSectionScrollEvent event,
    Emitter<SliverSectionScrollState> emit,
  ) async {
    if (state is! InitializingPositionsStateOnSliverSectionScrollState) return;

    var currentStateModel = state.stateModel.copyWith();

    for (final each in currentStateModel.globalKeys) {
      final RenderBox renderBox =
          each.currentContext?.findRenderObject() as RenderBox;

      List<double> eachSectionPosition =
          List<double>.from(currentStateModel.eachSectionPosition);

      eachSectionPosition.add(renderBox.localToGlobal(Offset.zero).dy);

      currentStateModel =
          currentStateModel.copyWith(eachSectionPosition: eachSectionPosition);
    }

    await event.animateToLastPosition();

    emit(SliverSectionScrollState.completedState(currentStateModel));
  }

  void _scrollListener(
    _ScrollListenerOnSliverSectionScrollEvent event,
    Emitter<SliverSectionScrollState> emit,
  ) async {
    if (state is! CompletedStateOnSliverSectionScrollState) return;

    double scrollPos = event.listScrollController.position.pixels +
        (kToolbarHeight + sliverTabBarHeight) +
        event.middleOfTheScreen;

    final positions = state.stateModel.eachSectionPosition.toSet().toList();

    int elementAt = 0;

    for (int i = 0; i < positions.length - 1; i++) {
      if (scrollPos >= positions[i] && scrollPos < positions[i + 1]) {
        elementAt = i;
        break;
      }
    }

    if (scrollPos >= positions.last) {
      elementAt = positions.length - 1;
    }

    add(
      SliverSectionScrollEvent.animateTabBarOnScroll(
        position: elementAt,
        tabBarScrollController: event.tabBarScrollController,
      ),
    );
  }

  void _animateToTabBarOnScroll(
    _AnimateTabBarOnScrollEventonSliverSectionScrollEvent event,
    Emitter<SliverSectionScrollState> emit,
  ) async {
    if (state.stateModel.scrollIndexPositionAt == event.position) return;

    var currentStateModel = state.stateModel.copyWith(
      scrollIndexPositionAt: event.position,
    );

    emit(SliverSectionScrollState.completedState(currentStateModel));

    await Future.delayed(const Duration(milliseconds: 100));

    await event.tabBarScrollController.scrollTo(
      index: event.position,
      duration: const Duration(milliseconds: 400),
      // alignment: -0.5,
    );
  }

  void _animateToPositionOnClick(
    _AnimateToPositionOnClick event,
    Emitter<SliverSectionScrollState> emit,
  ) async {
    final offset = state.stateModel.eachSectionPosition
        .elementAtOrNull(event.indexPosition);

    if (offset == null) return;

    final scrollPos = kToolbarHeight + sliverTabBarHeight + 70;

    // debugPrint("all elements: ${state.stateModel.eachSectionPosition}");

    await event.listScrollController.animateTo(
      offset - scrollPos,
      duration: const Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }
}
