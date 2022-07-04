import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_perfect_assignment/app/dio/dio.dart';
import 'package:pet_perfect_assignment/screen2/data/screen2_api.dart';
import 'package:pet_perfect_assignment/screen2/data/screen2_model.dart';

part 'screen2_event.dart';
part 'screen2_state.dart';

class Screen2Bloc extends Bloc<Screen2Event, Screen2State> {
  Screen2Bloc({required Screen2API api})
      : _api = api,
        super(Screen2StateInitial()) {
    on<Screen2LoadData>(_onScreen2LoadData);
  }

  final Screen2API _api;

  Future<FutureOr<void>> _onScreen2LoadData(
    Screen2LoadData event,
    Emitter<Screen2State> emit,
  ) async {
    // loading
    emit(Screen2StateLoading());

    try {
      // api call
      final posts = await _api.fetchPosts();

      // success
      emit(Screen2StateSuccess(posts));
    } on DioError catch (e) {
      // dio error
      final errorMsg = DioExceptions.errorString(e);
      log(
        'DIO Error in screen2data loading',
        error: errorMsg,
        stackTrace: StackTrace.current,
      );
      emit(Screen2StateFailure(errorMsg));
    } catch (e, st) {
      // app error
      log('App Error in screen2data loading', error: e, stackTrace: st);
      emit(Screen2StateFailure(e.toString()));
    }
  }
}
