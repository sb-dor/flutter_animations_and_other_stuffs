import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_client.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_server.dart';
import 'package:network_discovery/network_discovery.dart';

class NearbyServerStateModel {
  NearbyServer? server;
  NearbyClient? client;

  List<String> serverComingData = [];

  TextEditingController messageController = TextEditingController(text: '');

  Stream<NetworkAddress>? stream;
  List<NetworkAddress> networkAddress = [];
}
