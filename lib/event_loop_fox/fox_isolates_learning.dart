// evey isolate has it's own memory, event loop (event queue and microTask queue)
// that's why whenever you run you "main" function -> it starts all code in main Isolate
// and all your Flutter code is running in that main Isolate.
// but when you want to calculate some huge data, you can create new isolate, which has
// own memory and event loop, and share data between two isolates

import 'dart:isolate';

void main() {
  StackTrace.fromString("Data from stacktrace that were converted to string");

  // ReceivePort has a "sendPort" that we can send message with
  final receivePort = ReceivePort();

  final newIsolateSpawned = Isolate.spawn(newIsolate, receivePort.sendPort);

  receivePort.listen((Object? dataFromNewIsolate) {});
}

void newIsolate(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
}
