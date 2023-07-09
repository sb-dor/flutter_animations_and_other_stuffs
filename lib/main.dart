import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/animated_container_tween_anim_page.dart';
import 'package:flutter_animations_2/animation_pages/animted_list_page.dart';
import 'package:flutter_animations_2/animation_pages/animted_title_page.dart';
import 'package:flutter_animations_2/animation_pages/heart_animtaion_page.dart';
import 'package:flutter_animations_2/animation_pages/page_view_with_controller.dart';
import 'package:flutter_animations_2/firebase_push_notification/firebase_push_not.dart';
import 'package:flutter_animations_2/google_documentation_sign_in/google_sign_in_page.dart';
import 'package:flutter_animations_2/internet_controller/cubit/internet_conn_checker_cubit.dart';
import 'package:flutter_animations_2/local_notification/local_notification.dart';
import 'package:flutter_animations_2/models/game/main_character.dart';
import 'package:flutter_animations_2/multi_image_selector_page/multi_image_selector_page.dart';
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

  await PdfGenerator.init();
  runApp(GetMaterialApp(
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
        builder: (context, state) => MultiImageSelectorPage(),
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
