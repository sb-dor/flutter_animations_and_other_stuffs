import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/bloc/sliver_section_scroll_bloc.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/widgets/tabbar/sliver_section_scroll_tabbar_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const double sliverTabBarHeight = 55;

extension StringEx on String {
  String capitalize() {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class SliverSectionScrollTabBarLoadedWidget extends StatelessWidget {
  final ItemScrollController scrollController;

  const SliverSectionScrollTabBarLoadedWidget({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: Delegate(scrollController: scrollController),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final ItemScrollController scrollController;

  const Delegate({required this.scrollController}) : super();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<SliverSectionScrollBloc, SliverSectionScrollState>(
      builder: (context, state) {
        switch (state) {
          case InitialStateOnSliverSectionScrollState():
          case InProgressStateOnSliverSectionScrollState():
          case InitializingPositionsStateOnSliverSectionScrollState():
            return SliverSectionScrollTabBarLoading();
          case CompletedStateOnSliverSectionScrollState():
            final currentState = state.stateModel;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 175),
              padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: shrinkOffset <= 0.0
                    ? []
                    : [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Theme.of(context).dividerColor,
                          blurRadius: 2,
                        ),
                      ],
              ),
              child: ScrollablePositionedList.separated(
                itemScrollController: scrollController,
                separatorBuilder: (context, index) => SizedBox(width: 10),
                scrollDirection: Axis.horizontal,
                itemCount: currentState.sliverTitles.length,
                physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    key: currentState.sliverGlobalKeys[index],
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // context
                            //     .read<MainPageBloc>()
                            //     .add(ChangeSliverPersistentState(index: index, context: context))
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: currentState.scrollIndexPositionAt == index
                                    ? Theme.of(context).primaryColor.withValues(alpha: 0.3)
                                    : Theme.of(context).dividerColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                currentState.sliverTitles[index].capitalize(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: currentState.scrollIndexPositionAt == index
                                      ? Theme.of(context).primaryColor.withValues(alpha: 0.7)
                                      : Theme.of(context).textTheme.titleLarge?.color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }

  @override
  double get maxExtent => sliverTabBarHeight;

  @override
  double get minExtent => sliverTabBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
