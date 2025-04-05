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

abstract class IsolateCommunicator<Send extends Object?, Receive extends Object?>
    extends Stream<Receive>
    implements Sink<Send> {
  // Creates new Isolate
  // All errors from created Isolate will be sent to the main Isolate
  static Future<IsolateCommunicator<Send, Receive>>
  spawn<Send extends Object?, Receive extends Object?, Arg extends Object?>(
    void Function(IsolateCommunicator<Receive, Send> communicator, Arg arguments) entryPoint,
    Arg arguments,
  ) => communicator.spawn<Send, Receive, Arg>(entryPoint, arguments);

  // check whether Isolate is closed
  bool get isClosed;

  // check whether Isolate is still available for sending messages
  bool get isOpen;

  // checks the speed of answer that comes from Isolate
  Future<Duration> ping();
}

void main() => runZonedGuarded(
  () async {
    final communicator = await IsolateCommunicator.spawn(helloWorld, '2');
    communicator.listen((dataFromCreatedIsolate) {
      print("data is: $dataFromCreatedIsolate");
    });
    communicator.add('1');
  },
  (error, stackTrace) {
    print("error is coming to the main zone: $error | $stackTrace");
  },
);

void helloWorld(IsolateCommunicator<int, String> communicator, String text) {
  print("Initial argument: $text");
  Timer(const Duration(seconds: 3), () => communicator.close());
  communicator.listen((event) {
    final result = int.parse(event);
    communicator.add(result);
  });
}
