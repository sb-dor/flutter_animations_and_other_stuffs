import 'package:flutter/material.dart';

class SliverAppbarWithTabBar extends StatefulWidget {
  const SliverAppbarWithTabBar({super.key});

  @override
  State<SliverAppbarWithTabBar> createState() => _SliverAppbarWithTabBar();
}

class _SliverAppbarWithTabBar extends State<SliverAppbarWithTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<Tab> tabs = [
    const Tab(
      icon: Icon(Icons.camera),
      iconMargin: EdgeInsets.zero,
    ),
    const Tab(text: "Чаты"),
    const Tab(text: "Статус"),
    const Tab(text: "Звонки"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 1);
  }

  bool end = false;
  TransformationController controllerT = TransformationController();
  var initialControllerValue;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("WatsApp"),
              floating: true,
              pinned: true,
              bottom: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                onTap: (index) {
                  if (index == 0) tabController.index = 1;
                },
                controller: tabController,
                tabs: tabs,
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: tabController,
                children: [
                  Container(),
                  Center(
                    child: InteractiveViewer(
                      maxScale: 3,
                      minScale: 0.5,
                      transformationController: controllerT,
                      onInteractionStart: (d) {
                        initialControllerValue = controllerT.value;
                      },
                      onInteractionEnd: (d) {
                        controllerT.value = initialControllerValue;
                      },
                      child: Container(
                          color: Colors.red,
                          width: 200,
                          height: 200,
                          child: Image.network(
                              "https://img.freepik.com/premium-vector/notification-bell-vector-icon-trendy-neumorphism-style-vector-eps-10_532800-472.jpg?w=2000")),
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverFillViewport(
                        delegate: SliverChildListDelegate(
                          [],
                        ),
                      ),
                    ],
                  ),
                  const Center(child: Text("Tab 3"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
