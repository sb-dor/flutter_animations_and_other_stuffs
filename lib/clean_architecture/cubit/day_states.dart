import 'package:flutter_animations_2/clean_architecture/domain/models/day.dart';

abstract class DayStates {
  Day? day;

  DayStates({required this.day});
}

class LoadingDayState extends DayStates {
  LoadingDayState(Day? day) : super(day: day);
}

class ErrorDayState extends DayStates {
  ErrorDayState(Day? day) : super(day: day);
}

class LoadedDayState extends DayStates {
  LoadedDayState(Day? day) : super(day: day);
}
