import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/bloc_learning/bloc_to_bloc_comm/first_bloc/first_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SecondBlocEvents {}

abstract class SecondBlocStates {}

class InitState extends SecondBlocStates {}

class SecondBloc extends Bloc<SecondBlocEvents, SecondBlocStates> {
  late StreamSubscription firstBlocStreamSub;

  // if you want send data here from somewhere use this way -> BlocProvider.of<FirstBloc>(context);
  SecondBloc({required FirstBloc firstBloc}) : super(InitState()) {
    //

    //listen another bloc's states like this
    firstBlocStreamSub = firstBloc.stream.listen((event) {
      debugPrint("first bloc states in second bloc : ${event.runtimeType}");
    });
  }
}
