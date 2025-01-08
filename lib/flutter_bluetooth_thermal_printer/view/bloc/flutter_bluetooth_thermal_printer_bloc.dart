import 'dart:async';
import 'package:flutter_animations_2/flutter_bluetooth_thermal_printer/services/esc_local_keys.dart';
import 'package:flutter_animations_2/flutter_bluetooth_thermal_printer/view/bloc/state_model/flutter_bluetooth_thermal_printer_state_model.dart';
import 'package:flutter_animations_2/getit/locator.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_animations_2/flutter_bluetooth_thermal_printer/services/flutter_bluetooth_thermal_printer_service.dart'
    as service;

part 'flutter_bluetooth_thermal_printer_event.dart';

part 'flutter_bluetooth_thermal_printer_state.dart';

class FlutterBluetoothThermalPrinterBloc
    extends Bloc<FlutterBluetoothThermalPrinterEvent, FlutterBluetoothThermalPrinterState> {
  late final FlutterBluetoothThermalPrinterStateModel _currentState;

  final _bluetoothService = locator<service.BluetoothService>();

  FlutterBluetoothThermalPrinterBloc()
      : super(FlutterBluetoothThermalPrinterInitial(FlutterBluetoothThermalPrinterStateModel())) {
    //
    _currentState = state.escPosPrinterStateModel;

    //
    on<EscPosEmitterEvent>(
        (event, emit) => emit(FlutterBluetoothThermalPrinterInitial(_currentState)));
    //
    on<EscPosPrinterScannerEvent>(_escPosPrinterScannerEvent);

    on<EscPosConnectToDeviceEvent>(_escPosConnectToDeviceEvent);

    on<EscPosPrinterBluetoothStatusEvent>(_escPosPrinterBluetoothStatusEvent);

    on<EscPosPrintEvent>(_escPosPrintEvent);

    on<EscPosBluetoothAutoConnectEvent>(_escPosBluetoothAutoConnectEvent);

    on<EscPosPrinterScannerHelperEvent>(_escPosPrinterScannerEventHelper);

    on<EscPosPrinterScannerSubscriptionDisposeEvent>(_escPosPrinterScannerSubscriptionDisposeEvent);
  }

  void _escPosPrinterScannerEvent(
    EscPosPrinterScannerEvent event,
    Emitter<FlutterBluetoothThermalPrinterState> emit,
  ) async {
    // Start scanning for Bluetooth printer devices.
    final Stream<PrinterDevice?> printDevicesStream = _bluetoothService.scan(PrinterType.bluetooth);

    // Set the current state subscription to listen for scanned devices.
    _currentState.setSubscription(
      printDevicesStream.listen(
        // For each detected device, add a helper event to process it.
        (PrinterDevice? device) {
          add(EscPosPrinterScannerHelperEvent(device));
        },
      ),
    );
  }

  void _escPosPrinterScannerEventHelper(
    EscPosPrinterScannerHelperEvent event,
    Emitter<FlutterBluetoothThermalPrinterState> emit,
  ) {
    // Check if the event contains a valid device.
    if (event.device != null) {
      // Add the scanned device to the current state.
      _currentState.addDevice(event.device!);
      // Emit the initial state with the updated current state.
      emit(FlutterBluetoothThermalPrinterInitial(_currentState));
    }
  }

  void _escPosPrinterScannerSubscriptionDisposeEvent(
    EscPosPrinterScannerSubscriptionDisposeEvent event,
    Emitter<FlutterBluetoothThermalPrinterState> emit,
  ) async {
    // Dispose of the current subscription to stop listening for events.
    await _currentState.disposeSubscription();
    // Emit the initial state with the updated current state.
    emit(FlutterBluetoothThermalPrinterInitial(_currentState));
  }

  //
  void _escPosPrinterBluetoothStatusEvent(
    EscPosPrinterBluetoothStatusEvent event,
    Emitter<FlutterBluetoothThermalPrinterState> emit,
  ) async {
    // Listen for changes in the Bluetooth status from the Bluetooth service.
    await emit.forEach<BTStatus>(
      _bluetoothService.bluetoothState(),
      onData: (status) {
        // Log the current Bluetooth connection status for debugging.

        // Check if the Bluetooth status indicates no connection.
        if (status == BTStatus.none) {
          _currentState.setStateCheckerConnection(false);
          // Set a timer to disconnect after a specified duration if not connected.
          _currentState.setTimer(
            Timer(
              const Duration(seconds: EscLocalKeys.durationForCancelingPrinterConnectionTries),
              () async {
                // Disconnect from the printer if the timer fires.

                if (!_currentState.stateCheckerConnection) {
                  await _disconnect();
                }
              },
            ),
          );
        }
        // Check if the Bluetooth status indicates a successful connection.
        else if (status == BTStatus.connected) {
          // Clear the timer since the device is connected.
          _currentState.setStateCheckerConnection(true);
          _currentState.setTimer(null);
        }

        // Return the current printer state with updated information.
        return FlutterBluetoothThermalPrinterInitial(_currentState);
      },
    );
  }

  //
  void _escPosConnectToDeviceEvent(
    EscPosConnectToDeviceEvent event,
    Emitter<FlutterBluetoothThermalPrinterState> emit,
  ) async {
    // Check if there is a currently selected device and if it matches the device to connect.
    if (_currentState.selectedDevice != null &&
        _currentState.checkDeviceAddressWithSelectedDeviceAddress(event.device)) {
      // If the same device is selected, disconnect from it.
      await _disconnect();
      // Clear the saved device data from local storage.
      await _clearLocalSavedDevice();
      return; // Exit the function early since no connection is needed.
    }

    // If a different device is selected, disconnect from the current device.
    if (_currentState.selectedDevice != null) {
      final disconnected = await _bluetoothService.disconnectDevice(PrinterType.bluetooth);
      // If disconnected successfully, clear the selected device.
      if (disconnected) _currentState.selectedDevice = null;
      // Emit the initial state after disconnection.
      emit(FlutterBluetoothThermalPrinterInitial(_currentState));
    }

    // Attempt to connect to the new device specified in the event.
    final connected = await _bluetoothService.connectToDevice(
      selectedPrinter: event.device,
      type: PrinterType.bluetooth,
    );

    // If the connection is successful, update the current state with the new device.
    if (connected) {
      _currentState.selectedDevice = event.device;

      _showConnectedMessage(event.device);
      // Save the connected device information in local storage.
      await _saveDeviceInLocalStorage(event.device);
      // write logic for connecting automatically
    }

    // Emit the current state of the printer connection.
    emit(FlutterBluetoothThermalPrinterInitial(_currentState));
    // Log the connection status for debugging purposes.
  }

  //
  void _escPosBluetoothAutoConnectEvent(
    EscPosBluetoothAutoConnectEvent event,
    Emitter<FlutterBluetoothThermalPrinterState> emit,
  ) async {
    // Listen for changes in the Bluetooth adapter's state.
    await emit.forEach<BluetoothAdapterState>(
      _bluetoothService.bluetoothAvailableState,
      onData: (BluetoothAdapterState adapterState) {
        // Check if Bluetooth is enabled.
        if (adapterState == BluetoothAdapterState.on) {
          // Attempt to automatically connect to the last connected printer.
          _autoConnect(emit);
          // try to connect to last connected esc printer
        }
        // If Bluetooth is turned off, disconnect from the printer.
        else if (adapterState == BluetoothAdapterState.off) {
          _disconnect();
        }
        // Return the initial state of the printer connection.
        return FlutterBluetoothThermalPrinterInitial(_currentState);
      },
    );
  }

  void _autoConnect(Emitter<FlutterBluetoothThermalPrinterState> emit) async {
    // Set a timer to automatically disconnect if the connection attempt exceeds a specified duration.
    _currentState.setTimer(
      Timer(
        const Duration(seconds: EscLocalKeys.durationForCancelingPrinterConnectionTries),
        () async {
          // If auto connection is not active, disconnect from the printer.
          if (!_currentState.autoConnectionState) {
            await _disconnect();
          }
        },
      ),
    );

    // Retrieve the previously saved Bluetooth device from local storage.
    final localSavedDevice = await _getDeviceFromLocalStorage();

    // Check if a saved device was found.
    if (localSavedDevice != null) {
      // Attempt to connect to the saved Bluetooth device.
      final connected = await _bluetoothService.connectToDevice(
        selectedPrinter: localSavedDevice,
        type: PrinterType.bluetooth,
      );
      // If the connection was successful, update the current state.
      if (connected) {
        _currentState.selectedDevice = localSavedDevice; // Set the selected device.
        _currentState.setAutoConnectionState(true); // Mark auto connection as active.
        _currentState.setStateCheckerConnection(true);
        _currentState.setTimer(null); // Clear the timer since connected successfully.
        // Show a success message indicating the device is connected.
        _showConnectedMessage(localSavedDevice);
      } else {
        // If connection failed, disconnect from the printer.
        await _disconnect();
      }
    }
    // Emit the initial state of the printer connection.
    emit(FlutterBluetoothThermalPrinterInitial(_currentState));
  }

  void _showConnectedMessage(PrinterDevice? device) async {
    // Functions.showToast(message: "Успешное подключение к устройству ${device?.name ?? ''}!");

    // Retrieve app configuration to check if printing after every sale is enabled.
    // final appSettingsPrinter = await DbHelper.getAppConfigValue('print_after_every_sale');
    // If the setting is not enabled, show a reminder message.
    // if (appSettingsPrinter != '1') {
    //   Functions.showToast(
    //     message: 'Не забудьте включить функцию печати чека в настройках.',
    //   );
    // }
  }

  Future<void> _disconnect() async {
    await _bluetoothService.disconnectDevice(PrinterType.bluetooth);
    _currentState.selectedDevice = null;
    _currentState.setTimer(null);
    _currentState.setAutoConnectionState(false);
    add(const EscPosEmitterEvent());
  }

  // uncomment or remove unnecessary code
  // printing with created pdf
  void _escPosPrintEvent(
    EscPosPrintEvent event,
    Emitter<FlutterBluetoothThermalPrinterState> emit,
  ) async {
    // Check if the Bluetooth adapter is turned off; if so, exit the function.
    if (_bluetoothService.lastBluetoothAvailableState == BluetoothAdapterState.off) {
      return;
    }

    // Get the SoldInvoicePdfCreatorBloc from the current global context.
    // final pdfCustomerInvoiceBloc = BlocProvider.of<SoldInvoicePdfCreatorBloc>(
    //   _currentState.globalContext,
    // );
    //
    // // Create a SoldModel instance from the provided customer invoice.
    // final soldEntity = SoldModel.fromCustomerInvoice(
    //   event.customerInvoice,
    // );
    //
    // // Create a PDF for the invoice using the SoldModel instance and the current context.
    // final data = await pdfCustomerInvoiceBloc.createPdfForInvoiceEvent(
    //   soldEntity: soldEntity,
    //   context: _currentState.globalContext,
    //   // Determine if all quantities in the customer invoice details are zero or less.
    //   isEveryReturned: event.customerInvoice?.customerInvoiceDetails?.every(
    //         (el) => (el.qty ?? 0.0) <= 0.0,
    //       ) ??
    //       false,
    // );
    //
    // // Change the type of PDF template in the PdfTemplatesBlocCubit to a specific template.
    // _currentState.globalContext.read<PdfTemplatesBlocCubit>().changeTypeOfTemplate(
    //       PdfTemplateInvoiceTypeEnum.pdfTemplate80mmTemplate1,
    //     );
    //
    // // Create the PDF using the specified template and return the list of bytes.
    // final pdf = await _currentState.globalContext.read<PdfTemplatesBlocCubit>().createPdf(
    //       appBarTitle: '',
    //       templateName: '',
    //       pdfTemplateDataModel: data!,
    //       context: _currentState.globalContext,
    //       returnListBytes: true,
    //     );

    // Load the capability profile for the printer.
    final profile = await CapabilityProfile.load();
    // Create a generator for the specified paper size using the loaded profile.
    final generator = Generator(PaperSize.mm58, profile);
    // Initialize an empty list to hold the ticket bytes.
    var ticket = <int>[];

    // Rasterize each page of the PDF at a specified DPI and convert to an image.
    // await for (var page in Printing.raster(pdf!, dpi: 180)) {
    //   final image = page.asImage(); // Convert the page to an image.
    //   ticket += generator.image(image); // Generate the ticket bytes from the image.
    // }

    // Send the ticket bytes to the Bluetooth printer for printing.
    _bluetoothService.printWithBytes(
      bytes: ticket,
      printerType: PrinterType.bluetooth,
    );
  }

  // uncomment and write your own code for
  // saving printer device data with shared preferences
  Future<void> _saveDeviceInLocalStorage(PrinterDevice device) async {
    // Asynchronously saves the PrinterDevice details to shared preferences.

    // Saves the printer's Bluetooth address to shared preferences, or an empty string if the address is null.
    // await SharedPref.saveStringKeyValue(
    //   EscLocalKeys.printerDeviceAddress,
    //   device.address ?? '',
    // );
    //
    // // Saves the printer's name to shared preferences.
    // await SharedPref.saveStringKeyValue(
    //   EscLocalKeys.printerDeviceName,
    //   device.name,
    // );
    //
    // // Saves the printer's product ID to shared preferences, or an empty string if the product ID is null.
    // await SharedPref.saveStringKeyValue(
    //   EscLocalKeys.printerDeviceProductId,
    //   device.productId ?? '',
    // );
    //
    // // Saves the printer's vendor ID to shared preferences, or an empty string if the vendor ID is null.
    // await SharedPref.saveStringKeyValue(
    //   EscLocalKeys.printerDeviceVenID,
    //   device.vendorId ?? '',
    // );
  }

  // uncomment and write your own code for clearing data
  Future<void> _clearLocalSavedDevice() async {
    // await SharedPref.deleteValueByKey(EscLocalKeys.printerDeviceAddress);
    // await SharedPref.deleteValueByKey(EscLocalKeys.printerDeviceName);
    // await SharedPref.deleteValueByKey(EscLocalKeys.printerDeviceProductId);
    // await SharedPref.deleteValueByKey(EscLocalKeys.printerDeviceVenID);
  }

  // uncomment and write your own code for getting saved printer device
  Future<PrinterDevice?> _getDeviceFromLocalStorage() async {
    return null;
  
    // Asynchronously retrieves a PrinterDevice object from local storage, or returns null if not found.

    // Retrieves the printer's name from shared preferences using the key for device name.
    // final deviceName = SharedPref.getStringKeyValue(
    //   EscLocalKeys.printerDeviceName,
    // );
    //
    // // Retrieves the printer's Bluetooth address from shared preferences using the key for device address.
    // final deviceAddress = SharedPref.getStringKeyValue(
    //   EscLocalKeys.printerDeviceAddress,
    // );
    //
    // // If either the device name or address is null, return null, indicating no valid device is stored.
    // if (deviceName == null || deviceAddress == null) return null;
    //
    // // Retrieves the product ID of the printer from shared preferences using the key for product ID.
    // final deviceProductId = SharedPref.getStringKeyValue(
    //   EscLocalKeys.printerDeviceProductId,
    // );
    //
    // // Retrieves the vendor ID of the printer from shared preferences using the key for vendor ID.
    // final deviceVenID = SharedPref.getStringKeyValue(
    //   EscLocalKeys.printerDeviceVenID,
    // );
    //
    // // Constructs a PrinterDevice object using the retrieved name, address, product ID, and vendor ID.
    // final printerDevice = PrinterDevice(
    //   name: deviceName,
    //   address: deviceAddress,
    //   productId: deviceProductId,
    //   vendorId: deviceVenID,
    // );

    // return printerDevice;
    // Returns the constructed PrinterDevice object.
  }
}
