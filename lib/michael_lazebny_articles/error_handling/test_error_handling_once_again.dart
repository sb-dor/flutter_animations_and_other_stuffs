class RestApiException implements Exception {
  //
  RestApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;
}

final class StructureException extends RestApiException {
  //

  StructureException({
    required this.data,
    super.statusCode,
  }) : super(message: "Structure error");

  final Map<String, Object?> data;
}

final class UnAuthException extends RestApiException {
  UnAuthException({
    super.statusCode,
  }) : super(message: "User is not authed");
}

final class TestErrorHandlingOnceAgain {
  //

  // In your code, if bool.parse("1") throws an error, Dart will not automatically
  // catch it unless you explicitly handle it with a catch block.
  void tempChecker() {
    try {
      //

      _testingRequest();

      bool.parse("1");

      //
    } on RestApiException {
      // it will be sent inside zone even if you didn't catch them
      rethrow;
    }
    // if there is "catch" you have to catch "stacktrace", "error" (that is why use "Error.throwWithStackTrace" )
    // if you didn't catch it, dart will automatically catch them all
    // catch (error, stackTrace) {
    //   //
    //   Error.throwWithStackTrace(error, stackTrace);
    // }
  }

  void _testingRequest() {
    try {
      final test = <String, Object?>{
        "success1": false,
      };

      if (test['success'] == true) {
        throw StructureException(data: test);
      }

      if (test['success'] == false) {
        throw UnAuthException();
      }
    } on RestApiException {
      rethrow;
    } catch (error) {
      //
    }
  }
}
