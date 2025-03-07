import 'package:flutter/foundation.dart';

class MockHandlingErrors {
  int numberForMocks = 0;

  void mockErrors() {
    numberForMocks = 0; // Reset the counter each time you start mocking

    void throwMockError() {
      try {
        // This will throw a FormatException
        int.parse("fake");
      } catch (error, stackTrace) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
        ));

        numberForMocks++;
        if (numberForMocks < 100) {
          Future.delayed(Duration.zero,
              throwMockError); // Avoid stack overflow by scheduling the next call
        }
      }
    }

    throwMockError();
  }
}
