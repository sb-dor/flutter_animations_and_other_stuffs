import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothService {
  final _printerManager = PrinterManager.instance;

  final _flutterReactiveBle = FlutterReactiveBle();

  // scanning printer
  Stream<PrinterDevice?> scan(PrinterType type, {bool isBle = false}) async* {
    //
    try {
      if (defaultTargetPlatform == TargetPlatform.android &&
          FlutterBluePlus.adapterStateNow == BluetoothAdapterState.off) {
        await FlutterBluePlus.turnOn();
      }

      final permissions = await _initializeBluetoothOrRequestPermission();

      if (!permissions) {
        return;
      }

      yield* _flutterReactiveBle.scanForDevices(
        withServices: [],
        requireLocationServicesEnabled: false,
      ).asyncMap(
        (device) {
          final printerDevice = PrinterDevice(
            name: device.name, // Use the device name
            address: device.id, // Use the device address (or ID)
            // productId: device, // Example for extracting productId
            // vendorId: device.advertisementData.manufacturerData.values.first
            //     .toString(), // Example for extracting vendorId
          );

          return printerDevice;
        },
      );
    } catch (e) {
      debugPrint("bluetooth scan error is: $scan");
    }
  }

  Future<bool> _initializeBluetoothOrRequestPermission() async {
    // Determine required permissions based on Android version.
    List<Permission> requiredPermissions;
    if (await _isVersionLessThanS()) {
      requiredPermissions = [
        Permission.location,
      ];
    } else {
      requiredPermissions = [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ];
    }

    // Check which permissions are missing.
    List<Permission> missingPermissions = [];
    for (var permission in requiredPermissions) {
      if (!(await permission.isGranted)) {
        missingPermissions.add(permission);
      }
    }

    // If all permissions are granted, initialize Bluetooth, otherwise request them.
    if (missingPermissions.isEmpty) {
      if (await _isVersionLessThanS()) {
        final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isLocationEnabled) {
          // TODO: show message here: "Enable geolocation please"
          return false;
        }
      }
      return true;
    } else {
      PermissionStatus permissionStatus =
          await _requestPermissions(missingPermissions);
      if (permissionStatus == PermissionStatus.granted) {
        return true;
      } else {
        // Handle case where some permissions are not granted.
        await openAppSettings();
        return false;
      }
    }
  }

  // Helper function to request permissions.
  Future<PermissionStatus> _requestPermissions(
      List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    return statuses.values.every((status) => status.isGranted)
        ? PermissionStatus.granted
        : PermissionStatus.denied;
  }

  Future<bool> _isVersionLessThanS() async {
    // Create an instance of the DeviceInfoPlugin
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    // Get Android device information
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    // Check the version code (Android S is API 31)
    return androidInfo.version.sdkInt < 31;
  }

  Stream<BTStatus> bluetoothState() async* {
    yield* _printerManager.stateBluetooth;
  }

  // function for connection to device
  Future<bool> connectToDevice({
    required PrinterDevice selectedPrinter,
    required PrinterType type,
    bool reconnect = true,
    bool isBle = false,
    String? ipAddress,
  }) async {
    switch (type) {
      case PrinterType.bluetooth:
        return await PrinterManager.instance.connect(
          type: type,
          model: BluetoothPrinterInput(
            name: selectedPrinter.name,
            address: selectedPrinter.address!,
            isBle: isBle,
            autoConnect: reconnect,
          ),
        );

      // save address for auto connection

      case PrinterType.usb:
        // only windows and android
        return await PrinterManager.instance.connect(
          type: type,
          model: UsbPrinterInput(
            name: selectedPrinter.name,
            productId: selectedPrinter.productId,
            vendorId: selectedPrinter.vendorId,
          ),
        );
      case PrinterType.network:
        return await PrinterManager.instance.connect(
          type: type,
          model: TcpPrinterInput(
            ipAddress: ipAddress ?? selectedPrinter.address!,
          ),
        );
    }
  }

  // disconnect from device
  Future<bool> disconnectDevice(PrinterType type) async {
    return await _printerManager.disconnect(type: type);
  }

  Stream<BluetoothAdapterState> get bluetoothAvailableState =>
      FlutterBluePlus.adapterState;

  BluetoothAdapterState get lastBluetoothAvailableState =>
      FlutterBluePlus.adapterStateNow;

  // printer with bytes
  Future<bool> printWithBytes({
    required List<int> bytes,
    required PrinterType printerType,
  }) async {
    return await _printerManager.send(type: printerType, bytes: bytes);
  }
}
