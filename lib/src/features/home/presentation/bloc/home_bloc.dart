
import 'package:movie_planner/src/core/base/base_bloc.dart';
import 'package:movie_planner/src/core/base/base_event.dart';
import 'package:movie_planner/src/core/base/base_state.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {

  }
}