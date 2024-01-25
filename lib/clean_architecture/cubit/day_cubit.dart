import 'package:flutter_animations_2/clean_architecture/cubit/day_states.dart';
import 'package:flutter_animations_2/clean_architecture/domain/repository/day_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayCubit extends Cubit<DayStates> {
  DayCubit() : super(LoadingDayState(null));

  void getDataFromApi({
    required DayRepository repository,
    double latitude = 38.53575,
    double longitude = 68.77905,
  }) async {
    emit(LoadingDayState(null));
    var data = await repository.getDay(latitude: latitude, longitude: longitude);
    emit(LoadedDayState(data));
  }
}
