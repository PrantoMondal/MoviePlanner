import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_planner/src/core/base/base_bloc.dart';
import 'package:movie_planner/src/core/base/base_event.dart';
import 'package:movie_planner/src/core/base/base_state.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<LoadSplash>((event, emit) async {
      emit(SplashLoading());
      try {
        await Future.delayed(const Duration(seconds: 2));
        emit(SplashSuccess());
      } catch (e) {
        emit(SplashError("Something went wrong"));
      }
    });
  }
}
