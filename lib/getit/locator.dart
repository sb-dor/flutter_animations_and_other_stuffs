import 'package:get_it/get_it.dart';

import 'domain/meme_controller.dart';
import 'presentation/meme_repository.dart';


// locator should be globally in order to access it in anywhere in application
final locator = GetIt.instance; /// also you can write ->  [GetIt.I]


// registration all factories or singletons here
// call this func in the beginning of the main function
void setup() {

  // since your MemeDomainController is implementing MemeRepository you have to register them like this :
  locator.registerLazySingleton<MemeRepository>(() => MemeDomainController());

  // main different between registering factories and singleton is that getIt

  // if your class is not implementing or extending some another class
  // you can register them as usual:
  // locator.registerLazySingleton<MemeDomainController>(() => MemeDomainController());
}