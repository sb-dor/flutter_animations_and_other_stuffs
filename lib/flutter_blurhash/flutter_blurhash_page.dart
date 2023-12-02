import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class FlutterBlurHash extends StatefulWidget {
  const FlutterBlurHash({Key? key}) : super(key: key);

  @override
  State<FlutterBlurHash> createState() => _FlutterBlurHashState();
}

class _FlutterBlurHashState extends State<FlutterBlurHash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter blur image"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: BlurHash(
              hash: "L6Db=+9aM{e.01%Lt7Rk~V%1M|WC",
              image: "http://192.168.100.244:8000/api/image/url",
              curve: Curves.bounceInOut,
            ),
          )
        ]),
      ),
    );
  }
}
