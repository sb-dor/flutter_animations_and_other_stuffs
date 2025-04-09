import 'dart:async';

void main() async {
  print(1);

  // THIS WORKS EXACTLY SAME AS
  Future.delayed(const Duration(seconds: 1), () {
    print(2);
  });

  // THIS ONE
  Future.delayed(const Duration(seconds: 1)).then((_) => print(3));

  // after calling this, print(6) will be called
  Future(() {
    print(4);
  });

  // Future.sync works as synchronous code but it will be added to the event queue anyway
  //
  Future.sync(() {
    print(5);
  });

  // print(4) will be called first
  Future.delayed(Duration.zero, () {
    print(6);
  });

  // - Waits for all previously scheduled (non-delayed) futures to complete,
  //   then executes this block.
  // - Futures with delay and with DateTime, handling will be processed later.
  // - Futures without delay (also Duration.zero) are handled earlier.
  await Future(() {
    print("done future await");
  });

  print('after await');

  print(7);

  Future.microtask(() {
    print(8);
  });

  Future.delayed(Duration.zero, () {
    print(9);
  });

  scheduleMicrotask(() {
    print(10);
  });
}
