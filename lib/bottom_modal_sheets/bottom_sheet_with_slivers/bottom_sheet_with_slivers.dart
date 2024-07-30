import 'package:flutter/material.dart';

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
              builder: (context) => const _MyModalSheet(),
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
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                expandedHeight: 200.0,
              ),
              pinned: true,
            ),
            // SliverList for the scrollable list items
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 20,
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background images
        Image.asset('assets/image1.jpg', fit: BoxFit.cover),
        Positioned(
          top: 0,
          child: Image.asset('assets/image2.jpg', fit: BoxFit.cover),
        ),
        Positioned(
          top: 0,
          child: Image.asset('assets/image3.jpg', fit: BoxFit.cover),
        ),
        // Overlay content
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: Text(
            'Header Content',
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
