import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class SliverAppBarPage extends StatelessWidget {
  const SliverAppBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text("Hello"),
          centerTitle: false,
          floating: true,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: Placeholder(),
        ),
        //
        SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
                delegate: SliverChildListDelegate(List.generate(
                    100, (index) => Column(children: [_buildTile(), SizedBox(height: 10)]))))),
        //
        SliverToBoxAdapter(
            child: Container(
          height: 50,
          color: Colors.green,
        )),
        SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 50,
                    (context, index) => Column(children: [_buildTile(), SizedBox(height: 10)])))),
      ]),
    );
  }
}

Widget _buildTile() {
  return Row(children: [
    Container(width: 25, height: 25, color: Color(Faker().color.hashCode).withOpacity(1)),
    SizedBox(width: 10),
    Text("${Faker().lorem.word()}", style: TextStyle(fontWeight: FontWeight.bold))
  ]);
}
