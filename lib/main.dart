import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/animated_cart_page.dart';
import 'package:flutter_animations_2/animation_pages/animated_cart_with_bottom_navbar.dart';
import 'package:flutter_animations_2/animation_pages/neumorphic_page_transitions_container_page.dart';
import 'package:flutter_animations_2/animation_pages/page_view_with_controller.dart';
import 'package:flutter_animations_2/animations/vandad_nahandipoor_animations_course/3d_animations_in_flutter_how_to_stack_and_rotate_widget/3d_animations_in_flutter_how_to_stack_and_rotate_widget.dart';
import 'package:flutter_animations_2/animations/vandad_nahandipoor_animations_course/customer_painter_and_polygons/customer_painter_and_polygons.dart';
import 'package:flutter_animations_2/animations/vandad_nahandipoor_animations_course/flutter_animated_builder_and_transform/flutter_animated_builder_and_t_main_screen.dart';
import 'package:flutter_animations_2/animations/vandad_nahandipoor_animations_course/flutter_animated_builder_and_transform/flutter_animated_builder_own_text_moving.dart';
import 'package:flutter_animations_2/animations/vandad_nahandipoor_animations_course/flutter_chained_animations_curves_and_clippers/flutter_chained_animations_curves_and_clippers.dart';
import 'package:flutter_animations_2/animations/vandad_nahandipoor_animations_course/flutter_hero_animations/flutter_hero_animations.dart';
import 'package:flutter_animations_2/app_life_circle/did_change_app_life_circle_page.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/bottom_modal_sheet_cubit.dart';
import 'package:flutter_animations_2/custom_clippers/custom_clippers_screen.dart';
import 'package:flutter_animations_2/custom_clippers/own_customer_clippers.dart';
import 'package:flutter_animations_2/dart_features/dart_collections.dart';
import 'package:flutter_animations_2/dart_sync_async_isolates/dart_sync_and_async.dart';
import 'package:flutter_animations_2/delivery_food_ui/screens/home_screen/home_screen.dart';
import 'package:flutter_animations_2/dodo_pizzas_often_order_animation/dodo_pizza_often_order_animation.dart';
import 'package:flutter_animations_2/equatable/equatable_model.dart';
import 'package:flutter_animations_2/esc_pos_printer_with_bluetooth/esc_pos_printer_page.dart';
import 'package:flutter_animations_2/esc_pos_printer_with_bluetooth/esc_pos_printer_ui_helper.dart';
import 'package:flutter_animations_2/firebase_push_notification/firebase_push_not.dart';
import 'package:flutter_animations_2/flutter_background_service/flutter_background_service_helper.dart';
import 'package:flutter_animations_2/flutter_deep_link/firebase_dynamic_linking.dart';
import 'package:flutter_animations_2/flutter_deep_link/flutter_deep_linking_route.dart';
import 'package:flutter_animations_2/flutter_design_patters/factory_design.dart';
import 'package:flutter_animations_2/flutter_design_patters/prototype_design.dart';
import 'package:flutter_animations_2/flutter_design_patters/singleton_design.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/flutter_permissions_cubit.dart';
import 'package:flutter_animations_2/flutter_permissions/flutter_permissions_page.dart';
import 'package:flutter_animations_2/flutter_riverpod/flutter_riverpod_page.dart';
import 'package:flutter_animations_2/flutter_webview/flutter_webview.dart';
import 'package:flutter_animations_2/global_context/global_context.helper.dart';
import 'package:flutter_animations_2/internet_controller/cubit/internet_conn_checker_cubit.dart';
import 'package:flutter_animations_2/local_notification/awesome_notification_helper.dart';
import 'package:flutter_animations_2/local_notification/local_notification.dart';
import 'package:flutter_animations_2/method_channels/method_channels_page.dart';
import 'package:flutter_animations_2/nft_pages/nft_home_screen.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';
import 'package:flutter_animations_2/slivers/sliver_app_bar_page.dart';
import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/slivers_cubit.dart';
import 'package:flutter_animations_2/sqflite/page/sqflite_database_page.dart';
import 'package:flutter_animations_2/sqflite/sqflite_database_helper.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_map_screen.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_cubit.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'slivers/sliver_and_scroll_page.dart';
import 'slivers/sliver_appbar_with_tabbar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //get material app just for showing get's snackBar
  if (!kIsWeb) {
    await Firebase.initializeApp();
    await FirebasePushNot.initBackGroundNotification();
    await FirebasePushNot.initForeGroundNotification();
    await LocalNotification.initLocalNotification();
    await EscPosPrinterUIHelper.init();
    await AwesomeNotificationsHelper.initAwesomeNotifications();
    await FirebaseDynamicLinking.initDynamicLinks();
    await SqfLiteDatabaseHelper.initSqfLiteDatabase();
    await FlutterBackgroundServiceHelper.initService();
  }
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

  List<int> intgers = [1, 3, 4, 5, 1, 3, 4];
  List<bool> bools = [true, true, true];
  Map<String, dynamic> forLocalDisc = {'intgers': intgers, 'bools': bools};

  debugPrint("for local ${jsonEncode(forLocalDisc)}");

  DartCollections.hashMap();
  DartCollections.list();

  debugPrint("proto1 : ${prototype1.value} | proto2 : ${prototype2.value}");

  var eqModel = const EquatableModel(id: 1, name: "Avaz", age: 19);

  print("is model equals : ${eqModel == const EquatableModel(id: 1, name: "Avaz", age: 19)}");

  debugPrint("dart futures : ");
  DartSyncAndAsync.futures();
  debugPrint("dart streams:");
  DartSyncAndAsync.streams();
  debugPrint("sream listener : ");
  DartSyncAndAsync.addToStream();
  DartSyncAndAsync.streamListener();

  await PdfGenerator.init();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FlutterPermissionCubit()),
        BlocProvider(create: (_) => BottomModalSheetCubits()),
        BlocProvider(create: (_) => SliverCubit()),
        BlocProvider(create: (_) => MainMapCubit()),
        BlocProvider(create: (_) => InternetConnCubit())
      ],
      child: ProviderScope(
        child: MaterialApp(
            scrollBehavior: MyCustomScrollBehavior(),
            //if you want to use flutter deep linking use package "go_router"
            //get global context here
            // navigatorKey: GlobalContextHelper.globalNavigatorContext,
            theme: FlexThemeData.light(scheme: FlexScheme.green),
            darkTheme: FlexThemeData.dark(scheme: FlexScheme.green),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            //for adding named routes use like this
            //do not forget to write main route in your routes like this:
            //
            //->          "/" : (context) => YourHomeWidget()
            //
            //and do not forget to remove "home" parameter from MaterialApp widget, otherwise it will not work
            // initialRoute: '/',
            routes: {
              "/": (context) => const MainApp(),
              '/nft_home_screen': (context) => const NftHomeScreen()
            }),
      )));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      debugPrint("link : $event");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initiate the listener of internet conn here
    context.read<InternetConnCubit>().listenInternetConn();
    context.read<MainMapCubit>().initMap();
    showNo();
    initDynamicLinks();
  }

  void showNo() async {
    await AwesomeNotificationsHelper.showSimpleNotification(
        title: 'Hello', body: "IT IS AWESOME NOTIFICATION");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetConnCubit, bool>(
        builder: (context, state) => const OwnCustomClippers(),
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

//for web if listview horizontal is not scrolling
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
