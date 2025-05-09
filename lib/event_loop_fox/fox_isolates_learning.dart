// more info about isolates you can find here:

// 1. https://dart.dev/language/isolates
// 2. https://www.youtube.com/watch?v=kLoYHnh9XS0
// 3. https://youtu.be/kLoYHnh9XS0?t=9041
// 4. https://plugfox.dev/mastering-isolates/
// 5. https://github.com/sb-dor/FTube/blob/master/lib/features/youtube_video_player_screen/presentation/bloc/logic/download_video/download_video.dart

// every isolate has it's own memory, event loop (event queue and microTask queue)
// that's why whenever you run your "main" function -> it starts the whole code in main Isolate
// and all your Flutter code is running in that main Isolate.
// but when you want to calculate some huge data, you can create new isolate, which has
// own memory and event loop, and share data between two isolates

import 'dart:async';
import 'dart:isolate';

import 'contants/isoate_string_constants.dart';



void main() async {
  StackTrace.fromString("Data from stacktrace that were converted to string");

  runZonedGuarded(
    () async {
      final newIsolateSendPort = await initIsolate();
      newIsolateSendPort.send("Hello world");
      await Future.delayed(const Duration(seconds: 5));
      // newIsolateSendPort.send(_StringConstants.throwAnyError);
      // await Future.delayed(const Duration(seconds: 5));
      newIsolateSendPort.send(StringConstants.killIsolate);
      // after killing isolate no message will be sent and no computations will be invoked
      newIsolateSendPort.send("it's already dead and you will not get message");
    },
    (error, stackTrace) {
      //
      print("coming error to main zone: $error | $stackTrace");
    },
  );
}

Future<SendPort> initIsolate() async {
  /// [Completer] is an object that allows you to generate Future
  /// objects and complete them later whenever we want with a value or error.

  /// this [SendPort] should come from [createdIsolate]
  final completer = Completer<SendPort>();

  /// through this [ReceivePort]'s sendPort will be sent data from [createdIsolate]
  /// that's we need this is main isolate in order to listen data which will come
  /// from [createdIsolate]
  final mainIsolateReceivePort = ReceivePort();

  late StreamSubscription subs;

  /// listen the data which [createdIsolate] is sending to [mainIsolate]
  subs = mainIsolateReceivePort.listen((Object? object) {
    if (!completer.isCompleted && object is SendPort) {
      completer.complete(object);
    } else if (object is String && object == StringConstants.createdIsolateIsClosing) {
      subs.cancel();
      mainIsolateReceivePort.close();
    } else if (object is String && object.contains("<~|~>")) {
      print("coming error from createdIsolate: $object");
      Error.throwWithStackTrace(
        object.split("<~|~>").first.trim(),
        StackTrace.fromString(object.split("<~|~>").last.trim()),
      );
    } else {
      print("data is coming from createdIsolate to mainIsolate: $object");
    }
  });

  final createdIsolateInstance = await Isolate.spawn(
    createdIsolate,
    mainIsolateReceivePort.sendPort,
  );

  return completer.future;
}

void createdIsolate(SendPort mainIsolateSendPort) async {
  /// This [ReceivePort]'s `sendPort` is used to receive data from the [mainIsolate].
  /// It's essential for sending data to the [createdIsolate] for computation.
  /// Without it, communication from the [mainIsolate] to the [createdIsolate] isn't possible.
  /// However, you don't need to create a [ReceivePort] here if the goal is only to send data back to the [mainIsolate].
  final createdIsolateReceivePort = ReceivePort();
  mainIsolateSendPort.send(createdIsolateReceivePort.sendPort);

  createdIsolateReceivePort.listen((Object? object) {
    try {
      print("data is coming from mainIsolate to [createdIsolate]: $object | ${object.runtimeType}");

      if (object is String && object == StringConstants.throwAnyError) {
        throw UnimplementedError();
      }

      if (object is String && object == StringConstants.killIsolate) {
        /// when you want to somehow close isolate after some computation,
        /// better send message to [mainIsolate] that you are closing [createdIsolate],
        /// so the listener that is listing from [mainIsolate] closes itself
        mainIsolateSendPort.send(StringConstants.createdIsolateIsClosing);
        Isolate.current.kill();
      }
    } catch (error, stackTrace) {
      mainIsolateSendPort.send(
        "error from createdIsolate's stackTrace <~|~> ${stackTrace.toString()}",
      );
    }
  });
}
