import 'package:flutter/cupertino.dart';

//singleton design patters is whenever in class or file you call several instance of object
//the constructor of this class will work only once.
//It means that when you create many object of this class, you create only one object of this class in whole project
class Singleton {
  static Singleton? _instance;

  //we get instance of this class without calling object. Checking if we already create
  static Singleton? get instance => _instance ??= Singleton._();

  //private constructor
  Singleton._() { //instead of writing "_" for constructor you can write any name
    debugPrint("hello singleton");
  }

  void add() {
    debugPrint("singleton's add func");
  }
}

void checkInMain() {
  //Singleton singletonWithObject = Singleton(); //gives us an error, cause' we made private constructor

  //getting instance of "singleton" class without calling object
  Singleton? singleton = Singleton.instance;
  singleton?.add();
}
