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
    return "First exception message: $message";
  }
}

class ClientErrorException implements Exception {
  final String message;

  ClientErrorException(this.message);

  @override
  String toString() {
    return "Second exception message: $message";
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
    return "Structured exception message: $message";
  }
}

class MasteringErrorHandlingInDart {
  final Logger _logger = Logger();

  //
  //
  void exceptionCatcher() async {
    try {
      await _response();
    } on ServerErrorException catch (error, stackTrace) {
      debugPrint("getting server error from server: ${error.message} | stack: $stackTrace");
    } on ClientErrorException catch (error, stackTrace) {
      debugPrint("getting client error from server: ${error.message} | stack: $stackTrace");
    } on StructuredBackendException catch (error, stackTrace) {
      debugPrint("getting structured error from server: ${error.message} | stack: $stackTrace");
    } catch (error, stackTrace) {}
  }

  Future<Map<String, dynamic>> _response() async {
    const url = "http://192.168.100.3:8000/api/test/url";
    final response = await http.Client().get(
      Uri.parse(url),
    );

    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ClientErrorException("Client error occurred");
    }

    if (response.statusCode >= 500) {
      throw ServerErrorException("Server error occurred");
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (json case {"success": final result, "message": final message}) {
      throw StructuredBackendException(message, response.statusCode);
    }

    return {};
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
  final object = MasteringErrorHandlingInDart();

  object.exceptionCatcher();
}
