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
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const ClipRRect(child: _MyModalSheet()),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            );
          },
          child: const Text('Show Modal Bottom Sheet'),
        ),
      ),
    );
  }
}

class _MyModalSheet extends StatelessWidget {
  const _MyModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.9,
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
              leading: SizedBox(),
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/parallax_effect_images/efe-kurnaz.jpg',
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            // SliverList for the scrollable list items
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Item $index'));
                },
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
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        // Background images
        Image.asset(
          'assets/parallax_effect_images/efe-kurnaz.jpg',
          fit: BoxFit.none,
        ),
        // Positioned(
        //   bottom: -0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     height: 20,
        //     decoration: const BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(30),
        //           topRight: Radius.circular(30),
        //         )),
        //   ),
        // )
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
