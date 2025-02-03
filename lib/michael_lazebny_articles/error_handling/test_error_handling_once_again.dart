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
      final test = <String, Object?>{
        "success": false,
      };

      if (test['success'] == true) {
        throw StructureException(data: test);
      }

      if (test['success'] == false) {
        throw UnAuthException();
      }

      print(test);

      //
    } on RestApiException {
      // it will be sent inside zone even if you didn't catch them
      rethrow;
    } catch (error, stackTrace) {
      // remember of avoiding throws inside catches
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
