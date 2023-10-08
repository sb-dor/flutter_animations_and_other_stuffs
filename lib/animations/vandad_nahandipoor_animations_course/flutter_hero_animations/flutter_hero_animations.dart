import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}

const people = [
  Person(name: "John", age: 21, emoji: "😁"),
  Person(name: "Jane", age: 21, emoji: "😅"),
  Person(name: "Jack", age: 21, emoji: "😍"),
];

class FlutterHeroAnimations extends StatefulWidget {
  const FlutterHeroAnimations({Key? key}) : super(key: key);

  @override
  State<FlutterHeroAnimations> createState() => _FlutterHeroAnimationsState();
}

class _FlutterHeroAnimationsState extends State<FlutterHeroAnimations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("People")),
      body: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            final person = people[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsFlutterHeroAnimationPage(person: person)));
              },
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Hero(
                  tag: "${person.name}",
                  child: Material(
                      color: Colors.transparent,
                      child: Text("${person.emoji}",
                          style: TextStyle(fontSize: 40, color: Colors.black)))),
              title: Text("${person.name}"),
              subtitle: Text("${person.age} years"),
            );
          }),
    );
  }
}

class DetailsFlutterHeroAnimationPage extends StatelessWidget {
  final Person person;

  const DetailsFlutterHeroAnimationPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Hero(
              flightShuttleBuilder: (context, animation, flightDirection, fromContext, toContext) {
                late Widget widget;
                switch (flightDirection) {
                  case HeroFlightDirection.push:
                    widget = ScaleTransition(
                        scale: animation.drive(Tween<double>(begin: 0, end: 100)
                            .chain(CurveTween(curve: Curves.fastOutSlowIn))),
                        child: toContext.widget);
                    break;
                  case HeroFlightDirection.pop:
                    widget = fromContext.widget;
                    break;
                }
                return Material(color: Colors.transparent, child: widget);
              },
              tag: "${person.name}",
              child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${person.emoji}",
                    style: TextStyle(fontSize: 50),
                  )))),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 20),
          Text(person.name, style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          Text("${person.age} years old", style: TextStyle(fontSize: 20)),
        ]),
      ),
    );
  }
}
