import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

// REMEMBER!!! SYNCHRONOUS OPERATIONS WILL NOT BE SET INSIDE ANY OF: "Event Queue" and "MicroTask Queue"
// IT WILL BE HANDLED AT THAT EXACT TIME, IMMEDIATELY

// The event loop is an invisible engine that powers the asynchronous execution of code in Dart.
// It’s responsible for scheduling tasks, managing their execution, and ensuring that all operations in your Flutter app happen in the correct sequence. Dart’s event loop works by continuously checking two queues:
//
// - Event Queue: Contains tasks like user input events, network responses, or timers.

// - Microtask Queue: Contains small, immediate tasks like scheduled microtasks. These tasks are often internal actions triggered within Dart’s code.

// just imagine that Event loop is just a person that is alive throughout you app
// and does some tasks, for ex: He has to do jobs, 1) He has to check all "Future events" that come to the
// "Event queue" (place where functions come, like: Futures, Gestures) and to the "Micro task queue" (place where simple tasks come, like:  Future.microtask((){})
// This event loop runs inside one Isolate, Remember that each isolate has it's own "Event loop"

// Synchronous code runs immediately on the main thread before the event loop gets a chance to
// process any asynchronous events. The event loop does not explicitly “handle” synchronous
// operations—it just waits until the synchronous execution is complete before continuing with the
// next event.

// 'Future' has some methods, like: whenComplete or then,
// the main difference between whenComplete and then is that, whenComplete returns void | then returns something that "Future" returns

class EventLoopTest {
  EventLoopTest(this.eventQueue, this.microTaskQueue);

  final List<void Function()> eventQueue;
  final List<void Function()> microTaskQueue;

  void handleEventLoop() {
    // while app is running (until it finishes), event loop will work
    // when the microTaskQueue and eventQueue are empty, isolate finishes
    while (true) {
      if (microTaskQueue.isNotEmpty) {
        for (final each in microTaskQueue) {
          each();
        }
      } else {
        for (final each in eventQueue) {
          each();
        }
      }
    }
  }
}

void main() async {
  // 1) All events that we do in our app like: Functions, Future Functions, Gestures
  // All those jobs automatically go to the "Event Queue"
  // 2) In order to add microTask inside "MicroTask Queue" you have to use "Future.microtask((){})"

  scheduleMicrotask(() {});
  Future.microtask(() {}); // shortcut for "scheduleMicroTask"

  print("Sync operation");
  Future.sync(() {}); // shortcut for "Sync operations"

  Future<int?>(() => throw UnimplementedError()).then(
    (value) {
      //
    },
    onError: (error) {
      //
      print("error giving is: $error");
    },
  );

  Future<int?>(() => 2).whenComplete(() {
    // just a function when Future ends
  });

  // --
  simpleFixOfFreezedOnScreen();

  // --
  await someLongFunction().timeout(const Duration(milliseconds: 350)).onError((error, stackTrace) {
    print("error is si: $error | stack $stackTrace");

    // you can kill isolate in these ways:
    // exit(0);
    Isolate.current.kill();
  });
}

// but this function is not good for handling big computation
// better use Isolates
void simpleFixOfFreezedOnScreen() async {
  // simple code that fixes freezes on screen
  final totalTimer = Stopwatch()..start();
  final timer = Stopwatch()..start();
  for (int i = 0; i < 1000000000; i++) {
    // 16 is 60fps
    // 8 is 120fps
    if (timer.elapsedMilliseconds > 8) {
      await Future.delayed(Duration.zero);
      timer.reset();
    }
  }
  print("Stomwatch: ${totalTimer.elapsedMilliseconds} ms");
  totalTimer.stop();
  timer.start();
}

Future<void> someLongFunction() async {
  final periodic = Stream<int>.periodic(const Duration(milliseconds: 250), (i) => i);

  await periodic.take(3).forEach(log);
}
