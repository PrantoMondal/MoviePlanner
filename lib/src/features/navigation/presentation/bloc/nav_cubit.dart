import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/features/home/presentation/view/home_screen.dart';


part 'nav_state.dart';


class NavCubit extends Cubit<NavState> {
  NavCubit() : super(NavState());

  final List<Widget> pages = [
    HomeScreen(),
    const Center(child: Text('Movies')),
    const Center(child: Text('Booking')),
    const Center(child: Text('Profile')),
  ];

  void changeNavigationIndex(int index) {
    emit(state.copyWith(navIndex: index));
  }
}