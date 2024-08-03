import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheet_dynamic_size.dart';
import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/slivers_cubit.dart';
import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/slivers_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class SliverAndScrollPage extends StatefulWidget {
  const SliverAndScrollPage({Key? key}) : super(key: key);

  @override
  State<SliverAndScrollPage> createState() => _SliverAndScrollPageState();
}

class _SliverAndScrollPageState extends State<SliverAndScrollPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SliverCubit>().initPositionsAfterRender();
    });

    scrollController.addListener(() {
      context.read<SliverCubit>().position(scrollPosition: scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliverCubit, SliverStates>(
      builder: (context, state) {
        var currentState = state.sliverStateModel;
        return Scaffold(
          appBar: AppBar(title: const Text("Sliver and scroll page")),
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: _SliverPersistentHeaderW(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: currentState.redKey,
                  height: 1000,
                  color: Colors.red,
                  child: Center(
                    child: TextButton(
                      style:
                          const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                      onPressed: () => Navigator.pushNamed(context, '/nft_home_screen'),
                      child: const Text('Go'),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: currentState.blueKey,
                  height: 1000,
                  color: Colors.blue,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: currentState.yellowKey,
                  height: 1000,
                  color: Colors.yellow,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: Container(
                  key: currentState.pinkKey,
                  height: 1000,
                  color: Colors.pink,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _SliverPersistentHeaderW extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<SliverCubit, SliverStates>(builder: (context, mainPageState) {
      var currentState = mainPageState.sliverStateModel;
      return AnimatedContainer(
          duration: const Duration(milliseconds: 175),
          padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: shrinkOffset > 0.0 ? Colors.white : Theme.of(context).scaffoldBackgroundColor,
              boxShadow: shrinkOffset <= 0.0
                  ? []
                  : [
                      BoxShadow(
                          offset: const Offset(0, 1), color: Colors.grey.shade300, blurRadius: 1),
                    ]),
          child: ListView.separated(
              controller: currentState.horizontalScrollController,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: currentState.names.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async =>
                        BottomModalSheetDynamicSize.bottomDoubleModalSheet(context: context),
                    child: Container(
                        key: currentState.horizontalKeys[index],
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: currentState.selectedIndex == index
                                ? Colors.amber
                                : HexColor('#f3f2f8'),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(currentState.names[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: currentState.selectedIndex == index
                                        ? Colors.white
                                        : Colors.grey)))));
              }));
    });
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 55;

  @override
  // TODO: implement minExtent
  double get minExtent => 55;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
