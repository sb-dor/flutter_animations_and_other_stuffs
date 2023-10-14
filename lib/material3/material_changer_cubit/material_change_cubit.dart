import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialChangeCubit extends Cubit<bool> {
  MaterialChangeCubit() : super(true);

  void changeToMaterial3() => emit(true);

  void changeToMaterial2() => emit(false);
}
