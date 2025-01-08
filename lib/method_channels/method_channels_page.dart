import 'package:flutter/material.dart';
import 'package:flutter_animations_2/method_channels/android/battery_channel.dart';

class MethodChannelsPage extends StatefulWidget {
  const MethodChannelsPage({super.key});

  @override
  State<MethodChannelsPage> createState() => _MethodChannelsPageState();
}

class _MethodChannelsPageState extends State<MethodChannelsPage> {
  String butteryLevel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Method Channels")),
      body: Column(children: [
        const SizedBox(height: 15),
        Text("Buttery: $butteryLevel"),
        TextButton(
            onPressed: () async {
              butteryLevel = await BatteryChannel.getButtery();
              setState(() {});
            },
            child: const Text("Check Buttery")),
        TextButton(
            onPressed: () async {
              BatteryChannel.callPopUpMethod();
            },
            child: const Text("Native Popup"))
      ]),
    );
  }
}
