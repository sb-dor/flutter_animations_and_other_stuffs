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

  void tempChecker() {
    try {
      //

      _testingRequest();

      bool.parse("1");

      //
    } on RestApiException {
      // it will be sent inside zone even if you didn't catch them
      rethrow;
    } catch (error, stackTrace) {
      //
      Error.throwWithStackTrace(error, stackTrace);
    }
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
    } catch (error, stackTrace) {
      //
    }
  }
}
