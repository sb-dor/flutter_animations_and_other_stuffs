import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/cubit/state_model/nearby_server_state_model.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_client.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_server.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'nearby_server_states.dart';
import 'package:network_discovery/network_discovery.dart';

class NearbyServerCubit extends Cubit<NearbyServerStates> {
  late NearbyServerStateModel _currentState;

  NearbyServerCubit() : super(InitialNearbyServerState(NearbyServerStateModel())) {
    //
    _currentState = state.nearbyServerStateModel;
  }

  Future<void> initServer() async {
    await _destroyClient();
    if ((_currentState.server?.running ?? false)) {
      await _currentState.server?.stopServer();
      _currentState.server = null;
    } else {
      _currentState.server ??= NearbyServer(_data, _error);
      await _currentState.server?.start();
    }

    emit(InitialNearbyServerState(_currentState));
  }

  Future<void> _destroyServer() async {
    if ((_currentState.server?.running ?? false)) {
      await _currentState.server?.stopServer();
      _currentState.server = null;
    }
  }

  void initDevices() async {
    await _destroyServer();
    await _getIpAddress();
  }

  Future<void> _destroyClient() async {
    if ((_currentState.client?.isConnected ?? false)) {
      _currentState.client?.disconnect("DeviceInfo");
      _currentState.client = null;
    }
  }

  void _data(Uint8List data) {
    final receiveData = String.fromCharCodes(data);
    _currentState.serverComingData.add(receiveData);
    emit(InitialNearbyServerState(_currentState));
  }

  void _error(dynamic error) {
    debugPrint("error is $error");
  }

  void sendMessage() {
    print('server message');
    _currentState.server?.sendMessage(_currentState.messageController.text.trim());
    _currentState.serverComingData.add(_currentState.messageController.text.trim());
    emit(InitialNearbyServerState(_currentState));
  }

  void sendClientMessage() {
    print("client message");
    _currentState.client?.write(_currentState.messageController.text.trim());
  }

  Future<void> _getIpAddress() async {
    var networkInfo = await NetworkInfo().getWifiIP();
    if (networkInfo == null) return;

    _currentState.networkAddress.clear();

    emit(InitialNearbyServerState(_currentState));

    final String subnet = networkInfo.substring(0, networkInfo.lastIndexOf('.'));

    _currentState.stream = NetworkDiscovery.discover(subnet, 4000);

    _currentState.stream?.listen((networkAddress) {
      print("networks: ${networkAddress.ip}");
      if (_currentState.networkAddress.any((el) => el.ip == networkAddress.ip)) return;
      _currentState.networkAddress.add(networkAddress);
    });
    emit(InitialNearbyServerState(_currentState));
  }

  Future<void> connectToServer(NetworkAddress networkAddress) async {
    _currentState.client =
        NearbyClient(hostName: networkAddress.ip, port: 4000, onData: _data, onError: _error);
    _currentState.client?.connect();
    sendClientMessage();
    emit(InitialNearbyServerState(_currentState));
  }
}
