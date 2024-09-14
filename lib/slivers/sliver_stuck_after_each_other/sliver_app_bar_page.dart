import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/slivers/sliver_persistent_header_delegate/sliver_persistent_header_delegate_widget.dart';
import 'package:flutter_animations_2/slivers/sliver_stuck_after_each_other/multi_sliver/multi_sliver.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverAppBarPage extends StatelessWidget {
  const SliverAppBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Hello"),
            centerTitle: false,
            floating: true,
            pinned: true,
            expandedHeight: 70,
          ),
          SliverSection(
            title: "Hello",
            items: [
              // from "sliver_tools" package
              const SliverPinnedHeader(
                child: ColoredBox(
                  color: Colors.redAccent,
                  child: ListTile(
                    textColor: Colors.white,
                    title: Text("Hello theer"),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Column(
                      children: [
                        _buildTile(),
                        const SizedBox(height: 10),
                      ],
                    ),
                    childCount: 50,
                  ),
                ),
              ),
              // from "sliver_tools" package
              const SliverPinnedHeader(
                child: ColoredBox(
                  color: Colors.blueAccent,
                  child: ListTile(
                    textColor: Colors.white,
                    title: Text("Hello theer"),
                  ),
                ),
              )
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    _buildTile(),
                    const SizedBox(height: 10),
                  ],
                ),
                childCount: 50,
              ),
            ),
          ),
          // from "sliver_tools" package
          const CurrySliverHeader(Colors.purple, "Title1"),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    _buildTile(),
                    const SizedBox(height: 10),
                  ],
                ),
                childCount: 50,
              ),
            ),
          ),
          // from "sliver_tools" package
          const CurrySliverHeader(Colors.amber, "Title2"),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    _buildTile(),
                    const SizedBox(height: 10),
                  ],
                ),
                childCount: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTile() {
  final fake = faker.Faker();
  return Row(
    children: [
      Container(
        width: 25,
        height: 25,
        color: Color(fake.color.random.hashCode),
      ),
      const SizedBox(width: 10),
      Text(
        fake.lorem.word(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
