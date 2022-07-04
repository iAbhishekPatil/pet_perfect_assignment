part of 'screen2_bloc.dart';

@immutable
abstract class Screen2State {}

class Screen2StateInitial extends Screen2State {}

class Screen2StateLoading extends Screen2State {}

class Screen2StateFailure extends Screen2State {
  Screen2StateFailure(this.message);

  final String message;
}

class Screen2StateSuccess extends Screen2State {
  Screen2StateSuccess(this.data);

  final List<Screen2Model> data;
}
