import 'dart:async';
import 'dart:collection';
import 'package:flutter_animations_2/global_context/global_context.helper.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';

class FlutterBluetoothThermalPrinterStateModel {
  final globalContext = GlobalContextHelper.instance.globalNavigatorContext.currentContext!;

  final _devices = <PrinterDevice>[];

  UnmodifiableListView<PrinterDevice> get devices => UnmodifiableListView(_devices);

  Timer? _timerForScan;

  Timer? get timerForScan => _timerForScan;

  bool _autoConnectionState = false, _stateCheckerConnection = false;

  bool get autoConnectionState => _autoConnectionState;

  bool get stateCheckerConnection => _stateCheckerConnection;

  PrinterDevice? selectedDevice;

  StreamSubscription<PrinterDevice?>? _discoveringDevicesSubs;

  StreamSubscription<PrinterDevice?>? get discoveringDevicesSubs => _discoveringDevicesSubs;

  void setSubscription(StreamSubscription<PrinterDevice?>? subs) {
    _discoveringDevicesSubs = subs;
  }

  Future<void> disposeSubscription() async {
    await _discoveringDevicesSubs?.cancel();
    _discoveringDevicesSubs = null;
  }

  void setTimer(Timer? timer) {
    _timerForScan?.cancel();
    _timerForScan ??= timer;
  }

  void addDevice(PrinterDevice device) {
    final isDeviceExists = _devices.any(
      (element) => element.address == device.address && element.productId == device.productId,
    );

    if (isDeviceExists) return;

    _devices.add(device);
  }

  void selectDevice(PrinterDevice device) {
    selectedDevice = device;
  }

  void setAutoConnectionState(bool value) {
    _autoConnectionState = value;
  }

  void setStateCheckerConnection(bool value) {
    _stateCheckerConnection = value;
  }

  bool checkDeviceAddressWithSelectedDeviceAddress(PrinterDevice device) {
    return device.address == selectedDevice?.address && device.productId == device.productId;
  }
}
