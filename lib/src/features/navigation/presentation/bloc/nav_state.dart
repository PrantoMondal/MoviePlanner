part of 'nav_cubit.dart';

@immutable
class NavState {
  final int navIndex;

  const NavState({
    this.navIndex = 0,
  });

  NavState copyWith({
    int? navIndex,
  }) {
    return NavState(
      navIndex: navIndex ?? this.navIndex,
    );
  }}
