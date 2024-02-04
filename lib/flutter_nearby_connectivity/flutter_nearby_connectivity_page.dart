import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

enum DeviceType { advertiser, browser }

class FlutterNearbyConnectivityPage extends StatefulWidget {
  const FlutterNearbyConnectivityPage({super.key});

  @override
  State<FlutterNearbyConnectivityPage> createState() => _FlutterNearbyConnectivityPageState();
}

class _FlutterNearbyConnectivityPageState extends State<FlutterNearbyConnectivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _Ads())),
            child: Container(
              color: Colors.red,
              child: Center(
                child: Text("Ads"),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _Brows())),
            child: Container(
              color: Colors.green,
              child: Center(
                child: Text("Brows"),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _Ads extends StatefulWidget {
  const _Ads({super.key});

  @override
  State<_Ads> createState() => _AdsState();
}

class _AdsState extends State<_Ads> {
  final NearbyService _nearbyService = NearbyService();
  List<Device> listOfDevices = [];
  List<Device> listOfConnectedDevices = [];
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }

    await _nearbyService.init(
      serviceType: 'mpconn',
      deviceName: devInfo,
      strategy: Strategy.P2P_CLUSTER,
      callback: (isRunning) async {
        debugPrint("is running into init");
        if (isRunning) {
          // if (deviceType == DeviceType.browser) {
          // await _nearbyService.stopBrowsingForPeers();
          // await Future.delayed(Duration(microseconds: 200));
          // await _nearbyService.startBrowsingForPeers();
          // } else {
          await _nearbyService.stopAdvertisingPeer();
          await _nearbyService.stopBrowsingForPeers();
          await Future.delayed(const Duration(microseconds: 200));
          await _nearbyService.startAdvertisingPeer();
          await _nearbyService.startBrowsingForPeers();
          // }
        }
      },
    );

    subscription = _nearbyService.stateChangedSubscription(callback: (devices) {
      debugPrint("devices: ${devices.length}");
      listOfDevices.clear();
      listOfDevices.addAll(devices);
      listOfConnectedDevices.clear();
      listOfConnectedDevices
          .addAll(devices.where((d) => d.state == SessionState.connected).toList());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter nearby connectivity"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => init(),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listOfDevices.length,
              itemBuilder: (context, index) {
                return Text(
                  "${listOfDevices[index].deviceName}",
                  style: const TextStyle(color: Colors.black),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Brows extends StatefulWidget {
  const _Brows({super.key});

  @override
  State<_Brows> createState() => _BrowsState();
}

class _BrowsState extends State<_Brows> {
  final NearbyService _nearbyService = NearbyService();
  List<Device> listOfDevices = [];
  List<Device> listOfConnectedDevices = [];
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }

    await _nearbyService.init(
      serviceType: 'mpconn',
      deviceName: devInfo,
      strategy: Strategy.P2P_CLUSTER,
      callback: (isRunning) async {
        debugPrint("is running into init");
        if (isRunning) {
          // if (deviceType == DeviceType.browser) {
          await _nearbyService.stopBrowsingForPeers();
          await Future.delayed(Duration(microseconds: 200));
          await _nearbyService.startBrowsingForPeers();
          // } else {
          // await _nearbyService.stopAdvertisingPeer();
          // await _nearbyService.stopBrowsingForPeers();
          // await Future.delayed(const Duration(microseconds: 200));
          // await _nearbyService.startAdvertisingPeer();
          // await _nearbyService.startBrowsingForPeers();
          // }
        }
      },
    );

    subscription = _nearbyService.stateChangedSubscription(callback: (devices) {
      debugPrint("devices: ${devices.length}");
      listOfDevices.clear();
      listOfDevices.addAll(devices);
      listOfConnectedDevices.clear();
      listOfConnectedDevices
          .addAll(devices.where((d) => d.state == SessionState.connected).toList());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter nearby connectivity"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => init(),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listOfDevices.length,
              itemBuilder: (context, index) {
                return Text(
                  "${listOfDevices[index].deviceName}",
                  style: const TextStyle(color: Colors.black),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
