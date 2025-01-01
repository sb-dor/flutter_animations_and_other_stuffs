import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/sliver_section_scroll_with_persistent_bar/bloc/sliver_section_scroll_bloc.dart';
import 'package:flutter_animations_2/widgets/shimmer_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'tabbar/sliver_section_scroll_tabbar_loaded_widget.dart';

class SliverSectionScrollWithPersistentTabBarWidget extends StatelessWidget {
  const SliverSectionScrollWithPersistentTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SliverSectionScrollBloc(),
      child: _SliverSectionScrollWithPersistentTabBarUI(),
    );
  }
}

class _SliverSectionScrollWithPersistentTabBarUI extends StatefulWidget {
  const _SliverSectionScrollWithPersistentTabBarUI({super.key});

  @override
  State<_SliverSectionScrollWithPersistentTabBarUI> createState() =>
      _SliverSectionScrollWithPersistentTabBarWidgetState();
}

class _SliverSectionScrollWithPersistentTabBarWidgetState
    extends State<_SliverSectionScrollWithPersistentTabBarUI> {
  final ScrollController _listScrollController = ScrollController();
  final ItemScrollController _tabBarScrollController = ItemScrollController();
  double _middleOfTheScreen = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<SliverSectionScrollBloc>().add(SliverSectionScrollEvent.init());
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    // _tabBarScrollController.dispose();
    super.dispose();
  }

  void _initPositions() async {
    final sliverSectionScrollBlocState = context.read<SliverSectionScrollBloc>().state;

    if (sliverSectionScrollBlocState is! InitializingPositionsStateOnSliverSectionScrollState) {
      return;
    }

    _middleOfTheScreen = MediaQuery.of(context).size.height / 2.5;
    final currentPosition = _listScrollController.position.pixels;
    _listScrollController.jumpTo(0.0);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    context.read<SliverSectionScrollBloc>().add(
      SliverSectionScrollEvent.initPosition(
        animateToLastPosition: () async {
          _listScrollController.jumpTo(currentPosition);
        },
      ),
    );
    _listScrollController.addListener(_listener);
  }

  void _listener() {
    context.read<SliverSectionScrollBloc>().add(
          SliverSectionScrollEvent.scrollListener(
            listScrollController: _listScrollController,
            tabBarScrollController: _tabBarScrollController,
            middleOfTheScreen: _middleOfTheScreen,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sliver section scroll widget"),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SliverSectionScrollBloc, SliverSectionScrollState>(
            listener: (context, state) {
              if (state is InitializingPositionsStateOnSliverSectionScrollState) {
                _initPositions();
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<SliverSectionScrollBloc>().add(SliverSectionScrollEvent.init()),
          child: CustomScrollView(
            controller: _listScrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 300,
                  child: Placeholder(),
                ),
              ),
              SliverSectionScrollTabBarLoadedWidget(
                scrollController: _tabBarScrollController,
              ),
              BlocBuilder<SliverSectionScrollBloc, SliverSectionScrollState>(
                builder: (context, state) {
                  switch (state) {
                    case InitialStateOnSliverSectionScrollState():
                      return SliverToBoxAdapter();
                    case InProgressStateOnSliverSectionScrollState():
                      return SliverList.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ShimmerContainer(
                            height: 200,
                            borderRadius: BorderRadius.circular(10),
                          );
                        },
                      );
                    case CompletedStateOnSliverSectionScrollState():
                    case InitializingPositionsStateOnSliverSectionScrollState():
                      final currentStateModel = state.stateModel;
                      return SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverToBoxAdapter(
                          child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(height: 30),
                            itemCount: currentStateModel.categories.length,
                            itemBuilder: (context, index) {
                              return Container(
                                key: currentStateModel.globalKeys[index],
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            currentStateModel.categories[index].name ?? '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Add"),
                                        ),
                                      ],
                                    ),
                                    GridView.builder(
                                      padding: const EdgeInsets.all(8.0),
                                      primary: false,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns
                                        crossAxisSpacing: 8.0, // Space between columns
                                        mainAxisSpacing: 8.0, // Space between rows
                                        childAspectRatio: 3 / 2, // Aspect ratio of each grid item
                                      ),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          currentStateModel.categories[index].products?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final product =
                                            currentStateModel.categories[index].products?[index];
                                        return Card(
                                          elevation: 3,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.production_quantity_limits,
                                                  size: 48, color: Colors.blue),
                                              const SizedBox(height: 8),
                                              Text(
                                                product?.name ?? "Unnamed Product",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
