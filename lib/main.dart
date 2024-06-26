import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations_2/agora_rtc_engine/pages/index.dart';
import 'package:flutter_animations_2/animation_pages/flutter_tutorial_diegoveloper_list_animation/flutter_tutorial_diegoveloper_list_animation.dart';
import 'package:flutter_animations_2/animation_pages/youtube_coffee_app_animation/youtube_coffe_app_animation_page.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_concurrency/main_bloc_concurrency.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_to_bloc_comm/first_bloc/first_bloc.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_to_bloc_comm/second_bloc/second_bloc.dart';
import 'package:flutter_animations_2/bloc_learning/using_freezed/using_freezed_bloc.dart';
import 'package:flutter_animations_2/bloc_learning/using_freezed/using_freezed_page.dart';
import 'package:flutter_animations_2/bottom_modal_sheets/bottom_modal_sheets_cubit/bottom_modal_sheet_cubit.dart';
import 'package:flutter_animations_2/clean_architecture/cubit/day_cubit.dart';
import 'package:flutter_animations_2/dart_sync_async_isolates/dart_isolates.dart';
import 'package:flutter_animations_2/dart_sync_async_isolates/vandads_isolates/dart_iso_example1.dart';
import 'package:flutter_animations_2/dart_sync_async_isolates/vandads_isolates/dart_iso_example2.dart';
import 'package:flutter_animations_2/design_templates/mvvm/viewmodel_mvvm.dart';
import 'package:flutter_animations_2/dodo_pizza_phone_choose_pizza_animation/dodo_pizza_turn_screen_animation.dart';
import 'package:flutter_animations_2/esc_pos_printer_with_bluetooth/esc_pos_printer_ui_helper.dart';
import 'package:flutter_animations_2/firebase_push_notification/firebase_push_not.dart';
import 'package:flutter_animations_2/flutter_background_service/flutter_background_service_helper.dart';
import 'package:flutter_animations_2/flutter_camera/flutter_camera_helper.dart';
import 'package:flutter_animations_2/flutter_camera/flutter_camera_page.dart';
import 'package:flutter_animations_2/flutter_gestures/pages/flutter_draw_something_with_finger.dart';
import 'package:flutter_animations_2/flutter_gestures/pages/flutter_gestures_move_by_position_page.dart';
import 'package:flutter_animations_2/flutter_nearby_connectivity/yt_nearby_p2p_connection/cubit/nearby_server_cubit.dart';
import 'package:flutter_animations_2/flutter_permissions/cubit/flutter_permissions_cubit.dart';
import 'package:flutter_animations_2/flutter_web_scrapper/flutter_web_scrapper_page.dart';
import 'package:flutter_animations_2/global_context/global_context.helper.dart';
import 'package:flutter_animations_2/google_map/presentation/google_map_page.dart';
import 'package:flutter_animations_2/hive/hive_database_helper.dart';
import 'package:flutter_animations_2/internet_controller/cubit/internet_conn_checker_cubit.dart';
import 'package:flutter_animations_2/intl_localization/intl_localization_screen.dart';
import 'package:flutter_animations_2/local_notification/awesome_notification_helper.dart';
import 'package:flutter_animations_2/local_notification/local_notification.dart';
import 'package:flutter_animations_2/material3/material_changer_cubit/material_change_cubit.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/auto_route_package_navigation/main_auto_route_package_navigation.dart';
import 'package:flutter_animations_2/navigation/declarative_navigation/flutters_declarative_navigation/main_declerative_navigation_screen_default.dart';
import 'package:flutter_animations_2/navigation/imperative_navigation/imperative_nav_second_screen.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';
import 'package:flutter_animations_2/routing/routing_with_name.dart';
import 'package:flutter_animations_2/rxdart/rxdart_learning_screen.dart';
import 'package:flutter_animations_2/slivers/sliver_app_bar_page.dart';
import 'package:flutter_animations_2/slivers/slivers_bloc/slivers_cubit/slivers_cubit.dart';
import 'package:flutter_animations_2/sqflite/sqflite_database_helper.dart';
import 'package:flutter_animations_2/yandex_mapkit/yandex_mapkit_cubit/main_map_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart' as provider;
import 'package:url_strategy/url_strategy.dart';

import 'animation_pages/sin_wave_page.dart';
import 'animation_pages/youtube_pageview_scroll_animation_challenge/stack_scroll_animation_page.dart';
import 'animation_pages/youtube_flutter_location_animation/youtube_flutter_location_animation.dart';
import 'clean_architecture/presentation/clean_architecture_page.dart';
import 'custom_painter/progress_chart/progress_chart.dart';
import 'floor_database/floor_database_page.dart';
import 'flutter_blurhash/flutter_blurhash_page.dart';
import 'flutter_deep_link/flutter_deeplink_page.dart';
import 'flutter_gestures/pages/flutter_drag_element_to_widget_and_paste_page.dart';
import 'flutter_gestures/pages/flutter_draw_something_with_finger_new_one.dart';
import 'flutter_nearby_connectivity/yt_nearby_p2p_connection/presentation/flutter_p2p_connection_page.dart';
import 'generated/l10n.dart';
import 'getit/locator.dart';
import 'getit/repository/getit_page.dart';
import 'google_map/cubit/main_google_map_cubit.dart';
import 'navigation/declarative_navigation/go_router_dec_navigation/main_go_router_dec_navigation.dart';
import 'navigation/imperative_navigation/imperative_nav_first_screen.dart';
import 'overlay/overlay_page.dart';
import 'overlay/overlay_second_page.dart';
import 'slivers/sliver_and_scroll_page.dart';
import 'slivers/sliver_app_bar_title_animation.dart';
import 'web_page_with_url/helpers/routing_helper.dart';
import 'yandex_mapkit/yandex_map_screen.dart';
import 'youtube_exlode_page/youtube_explode_page.dart';

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
      ],
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (_) => ViewModelMVVM(),
          )
        ],
        child: ProviderScope(
          child: BlocBuilder<MaterialChangeCubit, bool>(builder: (context, materialUiState) {
            // return const MainAutoRoutePackageScreen();
            // return MainGoRouterDecNavigation();
            // return const MainDeclarativeNavigationScreen();
            // return FlutterDeepLinkPage();
            return MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // to use only en otherwise app will understand the language by your phone language
              // - optional remove if you want
              locale: Locale("ru"),
              // supported locales that will be used in app
              supportedLocales: S.delegate.supportedLocales,
              // routerConfig: webRouter,
              scrollBehavior: MyCustomScrollBehavior(),
              //if you want to use flutter deep linking use package "go_router"
              //get global context here
              scaffoldMessengerKey: GlobalContextHelper.globalNavigatorSContext,

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
        builder: (context, state) => const IndexPage(),
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
