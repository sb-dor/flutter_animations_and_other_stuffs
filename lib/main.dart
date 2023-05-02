import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/animated_container_tween_anim_page.dart';
import 'package:flutter_animations_2/animation_pages/animted_list_page.dart';
import 'package:flutter_animations_2/animation_pages/animted_title_page.dart';
import 'package:flutter_animations_2/animation_pages/heart_animtaion_page.dart';
import 'package:flutter_animations_2/animation_pages/page_view_with_controller.dart';
import 'package:flutter_animations_2/internet_controller/cubit/internet_conn_checker_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  //get material app just for showing get's snackBar
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [BlocProvider(create: (_) => InternetConnCubit())],
          child: const MainApp())));
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
        builder: (context, state) => const AnimatedListPage(),
        listener: (context, state) {
          //listen internet conn here
          if (state) {
            if (Get.isSnackbarOpen) {
              Get.closeCurrentSnackbar();
            }
          } else {
            Get.rawSnackbar(
                messageText:
                    const Text("No Internet", style: TextStyle(color: Colors.white)),
                duration: const Duration(days: 1));
          }
        });
  }
}
