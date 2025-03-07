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
  final ItemScrollController itemScrollController;
  final ScrollController listScrollController;

  const SliverSectionScrollTabBarLoadedWidget({
    super.key,
    required this.itemScrollController,
    required this.listScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: Delegate(
        itemScrollController: itemScrollController,
        listScrollController: listScrollController,
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final ItemScrollController itemScrollController;
  final ScrollController listScrollController;

  const Delegate({
    required this.itemScrollController,
    required this.listScrollController,
  }) : super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<SliverSectionScrollBloc, SliverSectionScrollState>(
      builder: (context, state) {
        switch (state) {
          case InitialStateOnSliverSectionScrollState():
          case InProgressStateOnSliverSectionScrollState():
          case InitializingPositionsStateOnSliverSectionScrollState():
            return const SliverSectionScrollTabBarLoading();
          case CompletedStateOnSliverSectionScrollState():
            final currentState = state.stateModel;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 175),
              padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: shrinkOffset <= 0.0
                    ? []
                    : [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: Theme.of(context).dividerColor,
                          blurRadius: 2,
                        ),
                      ],
              ),
              child: ScrollablePositionedList.separated(
                itemScrollController: itemScrollController,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                scrollDirection: Axis.horizontal,
                itemCount: currentState.sliverTitles.length,
                physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics()),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.read<SliverSectionScrollBloc>().add(
                            SliverSectionScrollEvent.animateToPositionOnClick(
                              indexPosition: index,
                              listScrollController: listScrollController,
                            ),
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: currentState.scrollIndexPositionAt == index
                              ? Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.3)
                              : Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          currentState.sliverTitles[index].capitalize(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: currentState.scrollIndexPositionAt == index
                                ? Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.7)
                                : Theme.of(context).textTheme.titleLarge?.color,
                          ),
                        ),
                      ),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
