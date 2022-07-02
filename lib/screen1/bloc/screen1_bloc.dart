import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_perfect_assignment/screen1/data/screen1_api.dart';

part 'screen1_event.dart';
part 'screen1_state.dart';

class Screen1Bloc extends Bloc<Screen1Event, Screen1State> {
  Screen1Bloc({required this.api}) : super(Screen1StateInitial()) {
    on<Screen1LoadData>(_onScreen1LoadData);
  }

  final Screen1API api;

  Future<FutureOr<void>> _onScreen1LoadData(
    Screen1LoadData event,
    Emitter<Screen1State> emit,
  ) async {
    // emit loading state
    emit(Screen1StateLoading());

    try {
      // api call
      final data = await api.fetchImage();

      // emit success
      emit(Screen1StateSuccess(data.url));
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
      emit(Screen1StateFailure(e.toString()));
    }
  }
}
