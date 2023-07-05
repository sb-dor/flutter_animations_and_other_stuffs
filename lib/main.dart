import 'package:flutter/material.dart';
import 'package:flutter_animations_2/animation_pages/animated_container_tween_anim_page.dart';
import 'package:flutter_animations_2/animation_pages/animted_list_page.dart';
import 'package:flutter_animations_2/animation_pages/animted_title_page.dart';
import 'package:flutter_animations_2/animation_pages/heart_animtaion_page.dart';
import 'package:flutter_animations_2/animation_pages/page_view_with_controller.dart';
import 'package:flutter_animations_2/google_documentation_sign_in/google_sign_in_page.dart';
import 'package:flutter_animations_2/internet_controller/cubit/internet_conn_checker_cubit.dart';
import 'package:flutter_animations_2/models/game/main_character.dart';
import 'package:flutter_animations_2/nft_pages/nft_home_screen.dart';
import 'package:flutter_animations_2/pdf/data/pdf_generator.dart';
import 'package:flutter_animations_2/pdf/pdf_page.dart';
import 'package:flutter_animations_2/ping_pong/ping_pong_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //get material app just for showing get's snackBar
  MainCharacter mainCharacter = MainCharacter("Alien");
  mainCharacter.race?.saySome();
  mainCharacter.race?.weapon.shoot();
  await PdfGenerator.init();
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
        builder: (context, state) => NftHomeScreen(),
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
