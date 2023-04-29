import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({Key? key}) : super(key: key);

  @override
  State<AnimatedListPage> createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  List<String> names = [
    "Range",
    "Flutter",
    'React',
    "React Native",
    "JavaScript",
    "TypeScript"
  ];

  List<String> forAdd = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addToList();
    });
  }

  void addToList() async {
    for (var element in names) {
      forAdd.add(element);
      await Future.delayed(const Duration(milliseconds: 475));
      listKey.currentState?.insertItem(forAdd.length - 1);
    }
  }

  void addSomething() {
    setState(() {
      forAdd.add("Flutter");
      listKey.currentState?.insertItem(forAdd.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => addSomething(), child: const Icon(Icons.add)),
        appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title: const Text('Animated List')),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedList(
                key: listKey,
                initialItemCount: forAdd.length,
                itemBuilder: (context, index, animation) => SlideTransition(
                    position: animation.drive(Tween<Offset>(
                            begin: const Offset(1, 5), end: const Offset(0, 0))
                        .chain(CurveTween(curve: Curves.elasticInOut))),
                    child: Text(forAdd[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                  color: Colors.grey[300]!,
                                  offset: const Offset(0, 5))
                            ]))))));
  }
}
