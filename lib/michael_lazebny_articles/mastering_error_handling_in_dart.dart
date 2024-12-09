import 'dart:async';
import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class ServerErrorException implements Exception {
  final String message;

  ServerErrorException(this.message);

  @override
  String toString() {
    return "server error exception message: $message";
  }
}

class ClientErrorException implements Exception {
  final String message;

  ClientErrorException(this.message);

  @override
  String toString() {
    return "client error exception message: $message";
  }
}

class StructuredBackendException implements Exception {
  final String message;
  final int statusCode;

  StructuredBackendException(
    this.message,
    this.statusCode,
  );

  @override
  String toString() {
    return "Structured error exception message: $message";
  }
}

class ExceptionHandler implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  ExceptionHandler(
    this.message, {
    this.statusCode,
    this.cause,
  });

  @override
  String toString() => 'ExceptionHandler('
      'message: $message, '
      'statusCode: $statusCode, '
      'cause: $cause'
      ')';
}

class MasteringErrorHandlingInDart {
  final Logger _logger;
  final http.Client _client;

  MasteringErrorHandlingInDart({required Logger logger, required http.Client client})
      : _logger = logger,
        _client = client;

  //
  //
  void exceptionCatcher() async {
    /// you can handle your exceptions
    /// calling "on" in order to handle only one specific
    /// exception or you can just use "catch" all of them
    /// remember to do [Error.throwWithStackTrace]
    try {
      await _response();
    } on ServerErrorException catch (error, stackTrace) {
      debugPrint("getting server error from server: ${error.message} | stack: $stackTrace");
    } on ClientErrorException catch (error, stackTrace) {
      debugPrint("getting client error from server: ${error.message} | stack: $stackTrace");
    } on StructuredBackendException catch (error, stackTrace) {
      debugPrint("getting structured error from server: ${error.message} | stack: $stackTrace");
    } catch (error, stackTrace) {
      /// use [Error.throwWithStackTrace] for throwing errors.
      /// Unlike the standard 'throw', this method retains the original stack trace.
      Error.throwWithStackTrace(
        error,
        stackTrace,
      );
    }
  }

  Future<Map<String, dynamic>> _response() async {
    try {
      const url = "http://192.168.100.3:8000/api/test/url";
      final response = await _client.get(
        Uri.parse(url),
      );

      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw ClientErrorException("Client error occurred");
      }

      if (response.statusCode >= 500) {
        throw ServerErrorException("Server error occurred");
      }

      final Map<String, dynamic> json = jsonDecode(response.body);

      if (json case {"success": false, "message": final message}) {
        throw StructuredBackendException(message, response.statusCode);
      }

      dynamic data = "1";

      data = data / 10;

      return {};
    } catch (error, stackTrace) {
      /// use [Error.throwWithStackTrace] for throwing errors.
      /// Unlike the standard 'throw', this method retains the original stack trace.
      Error.throwWithStackTrace(
        ExceptionHandler("Error occurred during handling response", cause: error),
        stackTrace,
      );
    }
    //
  }

  //
  //
  void mainFunction() {
    runZonedGuarded(
      () {
        // here you can handle errors that may happen in widget side
        // or send to the server
        // send to the firebase crashlytics
        FlutterError.onError = (flutterErrorDetails) {
          FirebaseCrashlytics.instance.recordFlutterError(
            FlutterErrorDetails(
              exception: flutterErrorDetails.exception,
              stack: flutterErrorDetails.stack,
              library: 'platform', // Indicating this is a platform-level error
            ),
          );

          _logger.log(
            Level.error,
            "Flutter widget side errors",
            error: flutterErrorDetails.exception,
            stackTrace: flutterErrorDetails.stack,
          );

          //
          // Activates on platform exceptions, like MethodChannel failures.
          // Handy method to log [PlatformDispatcher] error
          // or send to the server
          WidgetsBinding.instance.platformDispatcher.onError = (error, stackTrace) {
            _logger.log(
              Level.error,
              "Platform side errors",
              error: error,
              stackTrace: stackTrace,
            );

            // or maybe to any other server
            FirebaseCrashlytics.instance.recordFlutterError(
              FlutterErrorDetails(
                exception: error,
                stack: stackTrace,
                library: 'platform', // Indicating this is a platform-level error
              ),
            );

            // Returning 'true' indicates that the error has been handled.
            // Returning 'false' would allow the error to propagate further.
            return true;
          };
        };
      },
      (error, stackTrace) async {
        // or maybe any other server
        await FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
        );
      },
    );
  }
}

void main() {
  final object = MasteringErrorHandlingInDart(
    logger: Logger(),
    client: http.Client(),
  );

  object.exceptionCatcher();
}
