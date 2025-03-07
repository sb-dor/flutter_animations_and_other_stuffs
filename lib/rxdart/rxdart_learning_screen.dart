import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RxDartLearningScreen extends StatefulWidget {
  const RxDartLearningScreen({super.key});

  @override
  State<RxDartLearningScreen> createState() => _RxDartLearningScreenState();
}

class _RxDartLearningScreenState extends State<RxDartLearningScreen> {
  final Stream<String> _firstStream =
      Stream.periodic(const Duration(seconds: 2), (i) => "$i");

  final Stream<String> _secondStream =
      Stream.periodic(const Duration(seconds: 5), (i) => "hello world $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rx Dart Learning"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<String>(
              // rxdart's package for merging streams
              stream: MergeStream([_firstStream, _secondStream]),
              builder: (context, snapshot) {
                return Text(
                  "${snapshot.data ?? 0}",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
