import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetConnCubit extends Cubit<bool> {
  InternetConnCubit() : super(false);


  //use this in main
  //check the main_food_app_screen.dart
  void listenInternetConn() {
    Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen(connActivityRes);
  }

  void connActivityRes(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(false);
      debugPrint("No internet conn");
    } else {
      emit(true);
      debugPrint("Internet has been connected");
    }
  }
}
