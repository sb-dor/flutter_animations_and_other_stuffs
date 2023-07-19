import 'package:flutter/material.dart';
import 'package:flutter_animations_2/mothid%20channels/android/battery_channel.dart';

class MethodChannelsPage extends StatefulWidget {
  const MethodChannelsPage({Key? key}) : super(key: key);

  @override
  State<MethodChannelsPage> createState() => _MethodChannelsPageState();
}

class _MethodChannelsPageState extends State<MethodChannelsPage> {
  String butteryLevel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Method Channels")),
      body: Column(children: [
        SizedBox(height: 15),
        Text("Buttery: $butteryLevel"),
        TextButton(
            onPressed: () async {
              butteryLevel = await BatteryChannel.getButtery();
              setState(() {});
            },
            child: Text("Check Buttery")),
        TextButton(
            onPressed: () async {
              BatteryChannel.callPopUpMethod();
            },
            child: Text("Native Popup"))
      ]),
    );
  }
}
