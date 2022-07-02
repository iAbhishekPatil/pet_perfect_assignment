part of 'screen1_bloc.dart';

@immutable
abstract class Screen1State {}

class Screen1StateInitial extends Screen1State {}

class Screen1StateLoading extends Screen1State {}

class Screen1StateSuccess extends Screen1State {
  Screen1StateSuccess(this.imageUrl);
  final String imageUrl;
}

class Screen1StateFailure extends Screen1State {
  Screen1StateFailure(this.message);
  final String message;
}
