part of 'flutter_bluetooth_thermal_printer_bloc.dart';

@immutable
sealed class FlutterBluetoothThermalPrinterState {
  final FlutterBluetoothThermalPrinterStateModel escPosPrinterStateModel;

  const FlutterBluetoothThermalPrinterState(this.escPosPrinterStateModel);
}

final class FlutterBluetoothThermalPrinterInitial
    extends FlutterBluetoothThermalPrinterState {
  const FlutterBluetoothThermalPrinterInitial(super.escPosPrinterStateModel);
}
