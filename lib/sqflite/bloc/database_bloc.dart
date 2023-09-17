import 'dart:async';

import 'package:flutter_animations_2/sqflite/model/database_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DatabaseBlocState {}

class InitDatabaseBlocState extends DatabaseBlocState {}

class DatabaseBloc extends Bloc {
  DatabaseBloc() : super(InitDatabaseBlocState());

  final databaseController = StreamController<List<DatabaseModel>>.broadcast();

  void setupListening() {
    Stream<List<DatabaseModel>> modelStream = databaseController.stream;

    modelStream.listen((event) {
      print("database changing");
    });
  }
}
