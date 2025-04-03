// just imagine that Event loop is just a person that is alive throughout you app
// and does some tasks, for ex: He has to jobs, 1) He has to check all events that comes the
// "Event queue" (place where functions come, like:) and to the "Micro task queue" (place where simple functions come, like)
//
class EventLoopTest {
  EventLoopTest(this.eventQueue, this.microTaskQueue);

  final List<void Function()> eventQueue;
  final List<void Function()> microTaskQueue;

  void handleEventLoop() {
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

void main() {}
