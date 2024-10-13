import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_concurrency/main_bloc_concurrency.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_to_bloc_comm/first_bloc/first_bloc.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_to_bloc_comm/second_bloc/second_bloc.dart';
import 'package:flutter_animations_2/bloc_learning/using_freezed/using_freezed_bloc.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/bottom_modal_sheet_cubit.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_sheet_with_slivers/bottom_sheet_with_slivers.dart';
import 'package:flutter_animations_2/card_animation_from_karteto_app_own_code/own_karteto_app_code_card_animation.dart';
import 'package:flutter_animations_2/dart_features/dart_enums.dart';
import 'package:flutter_animations_2/design_templates/clean_architecture/presentation/cubit/day_cubit.dart';
import 'package:flutter_animations_2/design_templates/mvvm/viewmodel_mvvm.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/drag_and_drop_own_animation.dart';
import 'package:flutter_animations_2/drag_and_drop_own_animation/provider/drag_and_drop_provider.dart';
import 'package:flutter_animations_2/esc_pos_printer_with_bluetooth/esc_pos_printer_ui_helper.dart';
import 'package:flutter_animations_2/firebase_push_notification/firebase_push_not.dart';
import 'package:flutter_animations_2/flutter_background_service/flutter_background_service_helper.dart';
import 'package:flutter_animations_2/flutter_camera/flutter_camera_helper.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/cubit/nearby_server_cubit.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/flutter_permissions_cubit.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_functions/riverpod_function_page.dart';
import 'package:flutter_animations_2/flutter_riverpod/riverpod_generated_code/riverpod_generated_code_page.dart';
import 'package:flutter_animations_2/flutter_shortcuts/flutter_shortcuts.dart';
import 'package:flutter_animations_2/global_context/global_context.helper.dart';
import 'package:flutter_animations_2/hive/hive_database_helper.dart';
import 'package:flutter_animations_2/hive/lazy_load/hive_settings.dart';
import 'package:flutter_animations_2/internet_controller/cubit/internet_conn_checker_cubit.dart';
import 'package:flutter_animations_2/local_notification/awesome_notification_helper.dart';
import 'package:flutter_animations_2/local_notification/local_notification.dart';
import 'package:flutter_animations_2/material3/material_changer_cubit/material_change_cubit.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';
import 'package:flutter_animations_2/routing/routing_with_name.dart';
import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/slivers_cubit.dart';
import 'package:flutter_animations_2/sqflite/sqflite_database_helper.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart' as provider;
import 'package:url_strategy/url_strategy.dart';

import 'design_templates/todo_mvvm/view/todo_mvvm_view.dart';
import 'drag_and_drop_animation/animated_drag_drop_app.dart';
import 'files/files_page.dart';
import 'flutter_bluetooth_thermal_printer/view/bloc/flutter_bluetooth_thermal_printer_bloc.dart';
import 'flutter_bluetooth_thermal_printer/view/page/flutter_bluetooth_thermal_printer_page.dart';
import 'generated/l10n.dart';
import 'getit/locator.dart';
import 'google_map/cubit/main_google_map_cubit.dart';
import 'hive/lazy_load/pages/lazy_load_hive.dart';
import 'hive/users_todo_test/pages/users_page_test.dart';
import 'platform_widgets/platform_runner.dart';
import 'retrofit/view/retrofit_view.dart';
import 'slivers/nested_scroll_view_page.dart';
import 'slivers/sliver_and_scrolls/simple_sliver_and_scroll_page.dart';
import 'slivers/sliver_and_scrolls/sliver_and_scroll_from_diego_dev/home_sliver_with_scrollable_tabs.dart';
import 'slivers/sliver_and_scrolls/sliver_and_scroll_page.dart';
import 'slivers/sliver_app_bar_title_animation.dart';
import 'slivers/sliver_appbar_with_tabbar_page.dart';
import 'slivers/sliver_stuck_after_each_other/sliver_app_bar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  //get material app just for showing get's snackBar
  if (!kIsWeb) {
    await setup();

    try {
      await Firebase.initializeApp();
      await FirebasePushNot.initTopic();
      await FirebasePushNot.initBackGroundNotification();
      await FirebasePushNot.initForeGroundNotification();
      await LocalNotification.initLocalNotification();
      await EscPosPrinterUIHelper.init();
      await AwesomeNotificationsHelper.initAwesomeNotifications();
      await SqfLiteDatabaseHelper.initSqfLiteDatabase();
      await FlutterBackgroundServiceHelper.initService();
      await PdfGenerator.init();
      await HiveDatabaseHelper.instance.initHive();
      await FlutterCameraHelper.instance.initCameras();
      await HiveSettings.internal.initHive();

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    } catch (_) {}
  }

  const user = AccountStatus.admin;

  final typeOfUser = AccountStatus.fromString("admin11");
  print("user type of enum is: ${typeOfUser.desc}");

  // status.

  // MainCharacter mainCharacter = MainCharacter("Alien");
  // mainCharacter.race?.saySome();
  // mainCharacter.race?.weapon.shoot();
  //using firebase crashlytics for checking app bugs

  // ApplicationType applicationType = ApplicationType("RestaurantType");
  // applicationType.saveInvoice();
  //
  // Singleton? singleton = Singleton.instance;
  // Singleton? singleton2 = Singleton.instance;
  //
  // Prototype prototype1 = Prototype(value: 10);
  // Prototype prototype2 = prototype1.clone();
  //
  // prototype2.value = 12;
  //
  // List<int> intgers = [1, 3, 4, 5, 1, 3, 4];
  // List<bool> bools = [true, true, true];
  // Map<String, dynamic> forLocalDisc = {'intgers': intgers, 'bools': bools};
  //
  // debugPrint("for local ${jsonEncode(forLocalDisc)}");
  //
  // DartCollections.hashMap();
  // DartCollections.list();
  //
  // debugPrint("proto1 : ${prototype1.value} | proto2 : ${prototype2.value}");
  //
  // var eqModel = const EquatableModel(id: 1, name: "Avaz", age: 19);
  //
  // print("is model equals : ${eqModel == const EquatableModel(id: 1, name: "Avaz", age: 19)}");
  //
  // debugPrint("dart futures : ");
  // DartSyncAndAsync.futures();
  // debugPrint("dart streams:");
  // DartSyncAndAsync.streams();
  // debugPrint("sream listener : ");
  // DartSyncAndAsync.addToStream();
  // DartSyncAndAsync.streamListener();
  //
  // debugPrint("all isolates start here");
  // DartIsolates.runIsolate();
  // DartIsolates.runIsolate2();

  // DartIsoExample1.runIsolate();
  // DartIsoExample2.theMainFunc();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FlutterPermissionCubit()),
        BlocProvider(create: (_) => BottomModalSheetCubits()),
        BlocProvider(create: (_) => SliverCubit()),
        BlocProvider(create: (_) => MainMapCubit()),
        BlocProvider(create: (_) => InternetConnCubit()),
        BlocProvider(create: (_) => MaterialChangeCubit()),
        BlocProvider(create: (_) => MainBlocConcurrency()),
        BlocProvider(create: (_) => MainGoogleMapCubit()),
        BlocProvider(create: (_) => DayCubit()),

        //
        BlocProvider(create: (_) => FirstBloc()),

        //to init second bloc
        BlocProvider(create: (_) => SecondBloc(firstBloc: BlocProvider.of<FirstBloc>(_))),
        BlocProvider(create: (_) => NearbyServerCubit()),

        //
        BlocProvider(create: (_) => UsingFreezedBloc()),

        BlocProvider(create: (_) => FlutterBluetoothThermalPrinterBloc()),
      ],
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (_) => ViewModelMVVM(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => DragAndDropProvider(),
          ),
        ],
        child: ProviderScope(
          child: BlocBuilder<MaterialChangeCubit, bool>(builder: (context, materialUiState) {
            // return const MainAutoRoutePackageScreen();
            // return MainGoRouterDecNavigation();
            // return const MainDeclarativeNavigationScreen();
            // return FlutterDeepLinkPage();
            return GetMaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // to use only en otherwise app will understand the language by your phone language
              // - optional remove if you want
              locale: const Locale("ru"),
              // supported locales that will be used in app
              supportedLocales: S.delegate.supportedLocales,
              // routerConfig: webRouter,
              scrollBehavior: MyCustomScrollBehavior(),
              //if you want to use flutter deep linking use package "go_router"
              //get global context here
              navigatorKey: GlobalContextHelper.instance.globalNavigatorContext,

              theme: FlexThemeData.light(scheme: FlexScheme.green, useMaterial3: materialUiState),
              darkTheme:
                  FlexThemeData.dark(scheme: FlexScheme.green, useMaterial3: materialUiState),
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              //for adding named routes use like this
              //do not forget to write main route in your routes like this:
              //
              //->          "/" : (context) => YourHomeWidget()
              //
              //and do not forget to remove "home" parameter from MaterialApp widget, otherwise it will not work
              initialRoute: '/',
              routes: RoutingWithName.routes(),
              // initialRoute: "/"
            );
          }),
        ),
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
    super.initState();
    //initiate the listener of internet conn here
    context.read<InternetConnCubit>().listenInternetConn();
    context.read<MainMapCubit>().initMap();
    context.read<MainMapCubit>().initCoordinatesFromListOfCoordinatedWithCluster();
    // context.read<MainMapCubit>().initCoordinatedFromListOfCoordinates();
    // showNo();
    initDynamicLinks();
  }

  void showNo() async {
    await AwesomeNotificationsHelper.showSimpleNotification(
        title: 'Hello', body: "IT IS AWESOME NOTIFICATION");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetConnCubit, bool>(
        builder: (context, state) => const UsersPageTest(),
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
