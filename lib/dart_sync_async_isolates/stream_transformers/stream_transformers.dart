// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final class StreamTransformers {
  Stream<int> get _streamSource {
    final controller = StreamController<int>();
    // streams are not only data but errors too
    controller
      ..add(5)
      ..add(2)
      // ..addError(Exception("My error")) // when error appears / streamTransformer will handle that
      ..add(3)
      ..add(4)
      ..close();
    return controller.stream;
  }

  // https://rxmarbles.com/#throttleTime
  void throttleTime() async {
    // throttle will emit the first event then
    // will wait specific duration of time until other events should be emitted

    //
    // it means that it will run first event that is coming to the stream
    // and other events that are coming will be throw away until specific Duration of time ends
    final controller = StreamController<String>();

    final throttleTime = controller.stream.throttleTime(
      const Duration(seconds: 1),
    );

    throttleTime.listen(
      (data) {
        print("hello each data is coming: $data");
      },
    );

    controller.add("Searching 1"); // will take this one
    controller.add("Searching 1");
    controller.add("Searching 3");
    await Future.delayed(const Duration(seconds: 2));
    controller.add("Searching 4"); // will take this one
    await Future.delayed(const Duration(seconds: 3));
    controller.add("Searching 5"); // will take this one
    controller.add("Searching 6");
    controller.add("Searching 7");
    await Future.delayed(const Duration(milliseconds: 900));
    controller.add("Searching 8");


    print("hello buddy");
  }

  // https://rxmarbles.com/#debounceTime
  void debounceTime() async {
    // debounceTime will emit event only after specific duration of time ends
    // (every time when event comes to the queue it will refresh the duration and gets the last one after duration ends)

    // it is very helpful when you writing a code for searching something from the back-end
    // in order to not overload the backend you can use this stream transformer
    final controller = StreamController<String>();

    final debounceTime = controller.stream.debounceTime(
      const Duration(seconds: 1),
    );

    debounceTime.listen(
      (data) {
        print("hello each data is coming: $data");
      },
    );

    controller.add("Searching 1");
    controller.add("Searching 1");
    controller.add("Searching 3");
    await Future.delayed(const Duration(milliseconds: 500));
    controller.add("Searching 4"); // will take this one
    await Future.delayed(const Duration(seconds: 3));
    controller.add("Searching 5");
    controller.add("Searching 6");
    controller.add("Searching 7");
    await Future.delayed(const Duration(milliseconds: 900));
    controller.add("Searching 8"); // will take this one

    print("hello buddy");
  }

  void steamTransformerWithFromHandlers() {
    final newStream = _streamSource.transform<String>(
      // StreamTransformer.fromHandlers is useful
      // when you know that in stream will be errors
      // or something unusual that you want to know is adding inside stream
      StreamTransformer.fromHandlers(
        handleData: (int data, sink) {
          if (data % 2 == 0) {
            sink.add("value of data hey is: $data");
          }
        },
        handleError: (error, stackTrace, sink) {
          // errors will be handled here
          // 1. send error to your server
          // 2. you can transform error or add something else in sink if error occurs
          sink.add("value of data hey is: -100");
          // if you use this error handler
          // stream will be stopped
          Error.throwWithStackTrace(error, stackTrace);
        },
      ),
    );
    showStream(newStream);
  }

  void streamTransformerWithFromHandlersUsingClass() {
    final newStream = MyBaseTransformer().bind(_streamSource);
    showStream(newStream);
  }

  void simpleStreamTransformerAsyncExpand() {
    final asyncExpand = _streamSource.asyncExpand(
      (element) async* {
        //
        yield element;
      },
    );

    showStream(asyncExpand);
  }

  void simpleStreamTransformer() {
    final transformedStream = _streamSource.map<String>((element) => "each element: $element");
    // if you use "asyncMap" instead of "map" it means that you will be dealing with futures (asynchronously)
    // example;

    // any async code that you want to do do here inside "asyncMap"
    // do not use async code inside "listen" of stream
    final asyncTransformedStream = _streamSource.asyncMap<String>((element) async {
      await Future.delayed(const Duration(seconds: 1));
      return "element: is: $element";
    });

    showStream(asyncTransformedStream);
  }

  //
  void showStream(Stream<dynamic> stream) async {
    final streamIterator = StreamIterator(stream);
    // final canMoveNext = await streamIterator.moveNext();
    // print("can move next: $canMoveNext | current value: ${streamIterator.current}");
    // using while loop
    while (await streamIterator.moveNext()) {
      print("current in list: ${streamIterator.current}");
    }
  }

  // other way to iterate lists (not so popular and necessary, just for knowing)
  void syncIterator() {
    // iterating list using iterator
    List<int> numbers = [3, 5, 6, 7];
    final iterate = numbers.iterator;
    while (iterate.moveNext()) {
      print(iterate.current);
    }
  }
}

// create transformer for stream using classes (much more readable)
class MyBaseTransformer extends StreamTransformerBase<int, String> {
  @override
  Stream<String> bind(Stream<int> stream) async* {
    // StreamTransformer.fromHandlers is useful
    // when you know that in stream will be errors
    // or something unusual that you want to know is adding inside stream
    yield* stream.transform(
      StreamTransformer.fromHandlers(
        handleData: (int data, sink) {
          if (data % 2 == 0) {
            sink.add("value of data hey is: $data");
          }
        },
        handleError: (error, stackTrace, sink) {
          // errors will be handled here
          // 1. send error to your selver
          // 2. you can transform error or add something else in sink if error occurs
          sink.add("value of data hey is: -100");
          // if you use this error handler
          // stream will be stopped
          Error.throwWithStackTrace(error, stackTrace);
        },
      ),
    );
  }
}
