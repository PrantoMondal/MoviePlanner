part of 'splash_bloc.dart';

abstract class SplashState extends BaseState{}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {}

class SplashError extends SplashState {
  final String message;
  SplashError(this.message);
}
