import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

extension on String {
  String limit(int length) => length < this.length ? substring(0, length) : this;
}

class BlocObserverManager extends BlocObserver {
  const BlocObserverManager(this.logger);

  final Logger logger;

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<Object?, Object?> transition,
  ) {
    final logMessage = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType}')
      ..writeln('Event: ${transition.event.runtimeType}')
      ..writeln('Transition: ${transition.currentState.runtimeType} => '
          '${transition.nextState.runtimeType}')
      ..write('New State: ${transition.nextState?.toString().limit(100)}');

    logger.i(logMessage.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    final logMessage = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType}')
      ..writeln('Event: ${event.runtimeType}')
      ..write('Details: ${event?.toString().limit(200)}');

    logger.i(logMessage.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    final logMessage = StringBuffer()
      ..writeln('Error from bloc: ${bloc.runtimeType}')
      ..writeln(error.toString());

    // you can also send bloc errors to server here

    logger.e(
      logMessage.toString(),
      error: error,
      stackTrace: stackTrace,
    );

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    final logMessage = StringBuffer()..writeln('Closed Bloc: ${bloc.runtimeType}');

    logger.i(
      logMessage.toString(),
    );
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    final logMessage = StringBuffer()..writeln('Opened Bloc: ${bloc.runtimeType}');

    logger.i(
      logMessage.toString(),
    );
    super.onCreate(bloc);
  }
}
