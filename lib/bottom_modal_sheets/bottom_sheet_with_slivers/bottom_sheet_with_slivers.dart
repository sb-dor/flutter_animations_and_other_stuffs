import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheet_dynamic_size.dart';

class BottomSheetWithSlivers extends StatefulWidget {
  const BottomSheetWithSlivers({super.key});

  @override
  State<BottomSheetWithSlivers> createState() => _BottomSheetWithSliversState();
}

class _BottomSheetWithSliversState extends State<BottomSheetWithSlivers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fixed Image in Modal')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            BottomModalSheetDynamicSize.bottomDoubleModalSheet(context: context);
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   // backgroundColor: Colors.transparent,
            //   builder: (context) => const ClipRRect(child: _MyModalSheet()),
            //   // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            // );
          },
          child: const Text('Show Modal Bottom Sheet'),
        ),
      ),
    );
  }
}

class _MyModalSheet extends StatelessWidget {
  const _MyModalSheet();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.9,
      initialChildSize: 0.9,
      builder: (context, scrollController) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            // SliverPersistentHeader for the images at the top
            // SliverPersistentHeader(
            //   delegate: MySliverAppBar(
            //     expandedHeight: 200.0,
            //   ),
            //   pinned: false,
            //   floating: true,
            //   // floating: true,
            //   // pinned: false,
            // ),
            SliverAppBar(
              scrolledUnderElevation: 0,
              expandedHeight: 200,
              leading: const SizedBox(),
              backgroundColor: Colors.transparent,
              collapsedHeight: 0,
              toolbarHeight: 0,

              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  stretchModes: const [
                    StretchMode.zoomBackground,
                  ],
                  background: Image.asset(
                    'assets/parallax_effect_images/efe-kurnaz.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // SliverList for the scrollable list items
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background images
        Image.asset(
          'assets/parallax_effect_images/efe-kurnaz.jpg',
          fit: BoxFit.none,
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        )
        // Positioned(
        //   top: 0,
        //   child: Image.asset('assets/image2.jpg', fit: BoxFit.cover),
        // ),
        // Positioned(
        //   top: 0,
        //   child: Image.asset('assets/image3.jpg', fit: BoxFit.cover),
        // ),
        // Overlay content
        // Positioned(
        //   bottom: 16.0,
        //   left: 16.0,
        //   child: Text(
        //     'Header Content',
        //     style: TextStyle(
        //       fontSize: 32.0,
        //       color: Colors.white,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
