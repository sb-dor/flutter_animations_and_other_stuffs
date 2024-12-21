// ignore_for_file: avoid_print

import 'dart:async';

final class StreamTransformers {
  Stream<int> get _streamSource {
    final controller = StreamController<int>();
    // streams are not only data but errors too
    controller
      ..add(5)
      ..add(2)
      ..addError(Exception("My error")) // when error appears / streamTransformer will handle that
      ..add(3)
      ..add(4)
      ..close();
    return controller.stream;
  }

  void steamTransformerWithFromHandlers() {
    final newStream = _streamSource.transform<String>(
      // StreamTransformer.fromHandlers is useful
      // when you know that in stream will be errors
      // or something unusual that you want to now add in stream
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

  void syncIterator() {
    // iterating list using iterator
    List<int> numbers = [3, 5, 6, 7];
    final iterate = numbers.iterator;
    while (iterate.moveNext()) {
      print(iterate.current);
    }
  }
}

class MyBaseTransformer extends StreamTransformerBase<int, String> {
  @override
  Stream<String> bind(Stream<int> stream) async* {
    // StreamTransformer.fromHandlers is useful
    // when you know that in stream will be errors
    // or something unusual that you want to now add in stream
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
