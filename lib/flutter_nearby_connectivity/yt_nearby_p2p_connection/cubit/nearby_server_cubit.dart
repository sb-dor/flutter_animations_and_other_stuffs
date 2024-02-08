import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/cubit/state_model/nearby_server_state_model.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_client.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/models/nearby_server.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'nearby_server_states.dart';
import 'package:network_discovery/network_discovery.dart';

class NearbyServerCubit extends Cubit<NearbyServerStates> {
  late NearbyServerStateModel _currentState;

  NearbyServerCubit() : super(InitialNearbyServerState(NearbyServerStateModel())) {
    //
    _currentState = state.nearbyServerStateModel;
  }

  Future<void> initServer() async {
    await destroyClient();
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

  Future<void> destroyClient() async {
    if ((_currentState.client?.isConnected ?? false)) {
      _currentState.client?.disconnect(await _currentState.getDeviceName());
      _currentState.client = null;
    }
    emit(InitialNearbyServerState(_currentState));
  }

  void _data(Uint8List data) async {
    /// [getting just a string data]

    // final receiveData = String.fromCharCodes(data);
    // _currentState.serverComingData.add(receiveData);
    // emit(InitialNearbyServerState(_currentState));

    _currentState.filesData.addAll(data);

    debugPrint("data length: ${_currentState.filesData.length}");

    if ((_currentState.tempTimerForFile?.isActive ?? false)) {
      _currentState.tempTimerForFile?.cancel();
    }

    _currentState.tempTimerForFile = Timer(const Duration(seconds: 3), () async {
      final path = await getExternalStorageDirectory();

      var mime = lookupMimeType('', headerBytes: _currentState.filesData) ?? '';

      var extension = extensionFromMime(mime);

      print("extension for meme: $extension");

      final fileFromDat = File("${path?.path}/${DateTime.now().toString()}.$extension"); // every time new name

      fileFromDat.writeAsBytesSync(_currentState.filesData);

      _currentState.files.add(fileFromDat);

      _currentState.filesData.clear();

      emit(InitialNearbyServerState(_currentState));
    });
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

  // check for all devices which is started server in one ip address and in current port
  Future<void> _getIpAddress() async {
    var networkInfo = await NetworkInfo().getWifiIP();

    if (networkInfo == null) return;

    _currentState.networkAddress.clear();

    emit(InitialNearbyServerState(_currentState));

    final String subnet = networkInfo.substring(0, networkInfo.lastIndexOf('.'));

    _currentState.stream = NetworkDiscovery.discover(
      subnet,
      4000, // you can write your own port instead of 4000
    );

    if (_currentState.stream == null) return;

    await for (final networkAddress in _currentState.stream!) {
      print("networks: ${networkAddress.ip}");
      if (_currentState.networkAddress.any((el) => el.ip == networkAddress.ip)) return;
      _currentState.networkAddress.add(networkAddress);
      emit(InitialNearbyServerState(_currentState));
    }
  }

  Future<void> connectToServer(NetworkAddress networkAddress) async {
    _currentState.client = NearbyClient(
      hostName: networkAddress.ip,
      port: 4000, // you can write your own port instead of 4000
      onData: _data,
      onError: _error,
    );
    _currentState.client?.connect();

    sendClientMessage();

    await Future.delayed(const Duration(seconds: 1));

    emit(InitialNearbyServerState(_currentState));
  }

  Future<void> sendFileToServer() async {
    if (_currentState.client?.isConnected == false || _currentState.client == null) return;
    var image = await ImagePicker().pickMedia();
    if (image == null) return;
    _currentState.client?.sendFile(File(image.path));
  }
}
