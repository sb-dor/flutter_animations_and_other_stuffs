part of 'flutter_bluetooth_thermal_printer_bloc.dart';

@immutable
sealed class FlutterBluetoothThermalPrinterEvent {
  const FlutterBluetoothThermalPrinterEvent();
}

final class EscPosEmitterEvent extends FlutterBluetoothThermalPrinterEvent {
  const EscPosEmitterEvent();
}

final class EscPosPrinterScannerEvent extends FlutterBluetoothThermalPrinterEvent {
  const EscPosPrinterScannerEvent();
}

final class EscPosPrinterScannerHelperEvent extends FlutterBluetoothThermalPrinterEvent {
  final PrinterDevice? device;

  const EscPosPrinterScannerHelperEvent(this.device);
}

final class EscPosPrinterScannerSubscriptionDisposeEvent
    extends FlutterBluetoothThermalPrinterEvent {
  const EscPosPrinterScannerSubscriptionDisposeEvent();
}

final class EscPosPrinterBluetoothStatusEvent extends FlutterBluetoothThermalPrinterEvent {
  const EscPosPrinterBluetoothStatusEvent();
}

final class EscPosConnectToDeviceEvent extends FlutterBluetoothThermalPrinterEvent {
  final PrinterDevice device;

  const EscPosConnectToDeviceEvent(this.device);
}

final class EscPosPrintEvent extends FlutterBluetoothThermalPrinterEvent {
  // final CustomerInvoice? customerInvoice;

  // const EscPosPrintEvent(this.customerInvoice);
}

final class EscPosBluetoothAutoConnectEvent extends FlutterBluetoothThermalPrinterEvent {
  const EscPosBluetoothAutoConnectEvent();
}
