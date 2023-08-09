import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/neumorphic_page_transitions_container_page.dart';
import 'package:flutter_animations_2/esc_pos_printer_with_bluetooth/esc_pos_printer_page.dart';
import 'package:flutter_animations_2/esc_pos_printer_with_bluetooth/esc_pos_printer_ui_helper.dart';
import 'package:flutter_animations_2/firebase_push_notification/firebase_push_not.dart';
import 'package:flutter_animations_2/flutter_design_patters/factory_design.dart';
import 'package:flutter_animations_2/flutter_design_patters/prototype_design.dart';
import 'package:flutter_animations_2/flutter_design_patters/singleton_design.dart';
import 'package:flutter_animations_2/internet_controller/cubit/internet_conn_checker_cubit.dart';
import 'package:flutter_animations_2/local_notification/local_notification.dart';
import 'package:flutter_animations_2/method_channels/method_channels_page.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //get material app just for showing get's snackBar
  await Firebase.initializeApp();
  await FirebasePushNot.initBackGroundNotification();
  await FirebasePushNot.initForeGroundNotification();
  await LocalNotification.initLocalNotification();
  await EscPosPrinterUIHelper.init();
  // MainCharacter mainCharacter = MainCharacter("Alien");
  // mainCharacter.race?.saySome();
  // mainCharacter.race?.weapon.shoot();
  //using firebase crashlytics for checking app bugs
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  ApplicationType applicationType = ApplicationType("RestaurantType");
  applicationType.saveInvoice();

  Singleton? singleton = Singleton.instance;
  Singleton? singleton2 = Singleton.instance;

  Prototype prototype1 = Prototype(value: 10);
  Prototype prototype2 = prototype1.clone();

  prototype2.value = 12;

  debugPrint("proto1 : ${prototype1.value} | proto2 : ${prototype2.value}");

  await PdfGenerator.init();
  runApp(GetMaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.green),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.green),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [BlocProvider(create: (_) => InternetConnCubit())], child: const MainApp())));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initiate the listener of internet conn here
    context.read<InternetConnCubit>().listenInternetConn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetConnCubit, bool>(
        builder: (context, state) => MethodChannelsPage(),
        listener: (context, state) {
          //listen internet conn here
          if (state) {
            if (Get.isSnackbarOpen) {
              Get.closeCurrentSnackbar();
            }
          } else {
            Get.rawSnackbar(
                messageText: const Text("No Internet", style: TextStyle(color: Colors.white)),
                duration: const Duration(days: 1));
          }
        });
  }
}
