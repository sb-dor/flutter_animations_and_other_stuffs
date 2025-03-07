import 'package:flutter/material.dart';

class SliverAppBarTitleAnimation extends StatefulWidget {
  const SliverAppBarTitleAnimation({super.key});

  @override
  State<SliverAppBarTitleAnimation> createState() =>
      _SliverAppBarTitleAnimationState();
}

class _SliverAppBarTitleAnimationState extends State<SliverAppBarTitleAnimation>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final double _appbarExpandedHeight = 200;

  late final AnimationController _titlePaddingController;
  late final Animation<double> _titleAnimation;

  bool runController = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titlePaddingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _titleAnimation = Tween<double>(begin: 0, end: kToolbarHeight).animate(
      CurvedAnimation(
        parent: _titlePaddingController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _titlePaddingController.reverse();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        if (_scrollController.offset >= 0 &&
            _scrollController.offset <= _appbarExpandedHeight / 2) {
          if (runController) return;
          runController = true;
          _titlePaddingController.stop();
          _titlePaddingController.reverse();
        } else if (_scrollController.offset > _appbarExpandedHeight / 2) {
          if (!runController) return;
          runController = false;
          _titlePaddingController.stop();
          _titlePaddingController.forward();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _titlePaddingController,
        builder: (context, anim) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: _appbarExpandedHeight,
                floating: true,
                snap: true,
                pinned: true,
                leading: IconButton(
                  onPressed: () => [],
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      EdgeInsets.only(left: _titleAnimation.value, bottom: 10),
                  title: const Text(
                    "Sliver Appbar Title Animation",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(
                      100,
                      (index) => Text("${index + 1}"),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
