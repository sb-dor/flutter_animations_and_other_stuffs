import 'package:flutter/material.dart';
import 'package:flutter_animations_2/flutter_bluetooth_thermal_printer/view/bloc/flutter_bluetooth_thermal_printer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EscPosPrinterBluetoothPage extends StatefulWidget {
  const EscPosPrinterBluetoothPage({super.key});

  @override
  State<EscPosPrinterBluetoothPage> createState() => _EscPosPrinterBluetoothPageState();
}

class _EscPosPrinterBluetoothPageState extends State<EscPosPrinterBluetoothPage> {
  late final FlutterBluetoothThermalPrinterBloc _escPosPrinterBloc;

  @override
  void initState() {
    super.initState();
    _escPosPrinterBloc = BlocProvider.of<FlutterBluetoothThermalPrinterBloc>(context);
    _escPosPrinterBloc.add(
      const EscPosPrinterScannerEvent(),
    );
    _escPosPrinterBloc.add(
      const EscPosPrinterBluetoothStatusEvent(),
    );
  }

  @override
  void dispose() {
    _escPosPrinterBloc.add(const EscPosPrinterScannerSubscriptionDisposeEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: const Text("Bluetooth Устройства"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          final escPosPrinterBloc = context.watch<FlutterBluetoothThermalPrinterBloc>();

          //
          final escPosPrinterStateModel = escPosPrinterBloc.state.escPosPrinterStateModel;
          return RefreshIndicator(
            onRefresh: () async => context.read<FlutterBluetoothThermalPrinterBloc>().add(
                  const EscPosPrinterScannerEvent(),
                ),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: escPosPrinterStateModel.devices.length,
                  itemBuilder: (context, index) {
                    final device = escPosPrinterStateModel.devices[index];
                    return ListTile(
                      title: Text("Name: ${device.name}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Address: ${device.address}"),
                          Text("System: ${device.operatingSystem}"),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<FlutterBluetoothThermalPrinterBloc>().add(
                                EscPosConnectToDeviceEvent(device),
                              );
                        },
                        icon: Icon(
                          Icons.cast_connected,
                          color: escPosPrinterStateModel
                                  .checkDeviceAddressWithSelectedDeviceAddress(device)
                              ? Colors.amber
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
