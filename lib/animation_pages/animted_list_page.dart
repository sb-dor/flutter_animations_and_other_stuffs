import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animations/fade_animation.dart';
import 'package:flutter_animations_2/animations/scale_animation.dart';
import 'package:flutter_animations_2/animations/slide_animation.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

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
      await Future.delayed(const Duration(milliseconds: 100));
      listKey.currentState?.insertItem(forAdd.length - 1);
    }
  }

  Tween<Offset> offset =
      Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

  void addItem() async {
    forAdd.add(names[0]);
    await Future.delayed(const Duration(milliseconds: 30));
    print(forAdd.length);
    listKey.currentState?.insertItem(
        0); //if you want to add from bottom write "array.length - 1";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Animated List")),
        floatingActionButton: FloatingActionButton(
            onPressed: () => addItem(), child: const Icon(Icons.add)),
        body:
            ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
          AnimatedList(
              key: listKey,
              shrinkWrap: true,
              initialItemCount: forAdd.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index, anim) => SizeTransition(
                    sizeFactor: anim,
                    child: FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                          position: anim.drive(Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0))),
                          child: AnimatedSize(
                              duration: const Duration(milliseconds: 10),
                              child: Text(forAdd[index]))),
                    ),
                  )),
          const SizedBox(height: 50),
          const ScaleAnimation(
              child: Text("Hello word",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))
        ]));
  }
}
