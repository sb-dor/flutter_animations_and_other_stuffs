import 'package:flutter_animations_2/floor_database/db/floor_app_database.dart';
import 'package:get_it/get_it.dart';

import 'domain/meme_controller.dart';
import 'presentation/meme_repository.dart';

// locator should be globally in order to access it in anywhere in application
final locator = GetIt.instance;

/// also you can write ->  [GetIt.I]

// registration all factories or singletons here
// call this func in the beginning of the main function
Future<void> setup() async {
  // since your MemeDomainController is implementing MemeRepository you have to register them like this :
  locator.registerLazySingleton<MemeRepository>(() => MemeDomainController());

  // main different between registering factories and singleton in getIt is:
  // singleton creates single class for whole application (means that when you call particular class it will be called once)
  // factories is vise versa, unlike singleton it will create the new instance of particular class every time when you call that class

  // if your class is not implementing or extending some another class
  // you can register them as usual:
  // locator.registerLazySingleton<MemeDomainController>(() => MemeDomainController());

  // floor database registration:
  // final database = await $FloorFloorAppDatabase.databaseBuilder('floor_app_database.db').build();
  //
  // locator.registerLazySingleton<FloorAppDatabase>(() => database);
}
