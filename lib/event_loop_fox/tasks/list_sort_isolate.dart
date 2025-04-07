import 'dart:isolate';

void main() async {
  final mainIsolateReceivePort = ReceivePort();
  final newIsolate = await Isolate.spawn(entryPoint, message);
  mainIsolateReceivePort.listen(onData)
}
