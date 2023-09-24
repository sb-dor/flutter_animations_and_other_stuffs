import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animations_2/models/cars/bmw.dart';

class DartSyncAndAsync {
  static void futures() async {
    //futures will work at the end if  there is no any "await" on top or below
    Future(() => debugPrint("first element of queue's event"));
    Future(() => debugPrint("second element of queue's event"));

    //this microTasks will work after simple debugs
    Future.microtask(() => debugPrint("first element of queue's microTask"));
    scheduleMicrotask(() => debugPrint("second element of queue's microTask"));

    //futures will work at the end
    Future<List<Bmw>> list = Future(() {
      debugPrint("list bmw : ");
      return <Bmw>[];
    });

    List<Bmw> list2 = await Future(() => <Bmw>[]);
    debugPrint("list 2 : $list2");

    //this debugs will work at first if there is no any "await" from top of it
    debugPrint("last1");
    debugPrint("last2");
    debugPrint("last3");
    debugPrint("last4");
    debugPrint("last5");
    debugPrint("last6");
  }

  static void streams() {
    var stream = generatorId();
    stream.listen((event) {
      debugPrint("changing event : $event");
    });
  }

  static Stream<int> generatorId() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  static StreamController<int> intStreamController = StreamController<int>();

  static Stream<int> intStreamListener = intStreamController.stream;

  static void addToStream() async {
    for (var i = 100; i < 110; i++) {
      await Future.delayed(const Duration(seconds: 1));
      intStreamController.add(i);
    }
  }

  static void streamListener() {
    intStreamListener.listen((event) {
      debugPrint("stream listener : $event");
    });
  }
}
