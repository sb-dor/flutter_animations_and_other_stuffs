import 'package:flutter/material.dart';

class NestedScrollViewPage extends StatefulWidget {
  const NestedScrollViewPage({Key? key}) : super(key: key);

  @override
  State<NestedScrollViewPage> createState() => _NestedScrollViewPageState();
}

class _NestedScrollViewPageState extends State<NestedScrollViewPage> {
  final ScrollController _nestedScrollController = ScrollController();

  bool sliverAppBarEnd = false;
  double offsetToMinus = 0.0;

  List<Tab> tabs = [
    Tab(text: "First screen"),
    Tab(text: "Second screen"),
    Tab(text: "Third screen"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nestedScrollController.addListener(() {
        if (_nestedScrollController.offset >= kToolbarHeight && sliverAppBarEnd == false) {
          sliverAppBarEnd = true;
          offsetToMinus = (_nestedScrollController.offset - kToolbarHeight) + 10;
        } else {
          sliverAppBarEnd = false;
          offsetToMinus = 0.0;
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
            controller: _nestedScrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    title: Text("Nested scroll view"),
                    backgroundColor: Colors.amber,
                    pinned: true,
                    floating: true,
                    bottom: TabBar(tabs: tabs),
                  )
                ],
            body: TabBarView(children: [
              Column(
                children: [
                  if (sliverAppBarEnd) SizedBox(height: offsetToMinus),
                  Expanded(
                    child: CustomScrollView(slivers: [
                      SliverPersistentHeader(
                        delegate: _HelloWorldDelegate(),
                        floating: true,
                        pinned: true,
                      ),
                      SliverToBoxAdapter(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            separatorBuilder: (context, index) => SizedBox(height: 10),
                            itemCount: 30,
                            itemBuilder: (context, index) {
                              return Text("${index + 1}");
                            }),
                      )
                    ]),
                  ),
                ],
              ),
              Container(),
              Container()
            ])),
      ),
    );
  }
}

class _HelloWorldDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        height: 30, color: Colors.red, child: Text("Hello world", style: TextStyle(fontSize: 20)));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 30;

  @override
  // TODO: implement minExtent
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
