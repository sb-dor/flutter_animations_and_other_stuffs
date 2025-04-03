// just imagine that Event loop is just a person that is alive throughout you app
// and does some tasks, for ex: He has to jobs, 1) He has to check all events that comes the
// "Event queue" (place where functions come, like: Future.microtask((){}) ) and to the "Micro task queue" (place where simple functions come, like: Functions, Futures)
// This event loop runs inside one Isolate, Remember that each isolate has it's own "Event loop"
import 'dart:async';

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

void main() {
  // 1) All events that we do in our app like: Functions, Future Functions,
  // All that works go the "Event Queue" automatically
  // 2) In order to add microTask inside "MicroTask Queue" you have to use "Future.microtask((){})"

  scheduleMicrotask(() {});
  Future.microtask(() {}); // shortcut for "scheduleMicrotask"
}
