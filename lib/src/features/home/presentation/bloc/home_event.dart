part of 'home_bloc.dart';

abstract class HomeEvent extends BaseEvent {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovies extends HomeEvent {
  final String category;

  const FetchMovies({required this.category});

  @override
  List<Object?> get props => [category];
}

class RefreshMovies extends HomeEvent {
  final String category;

  const RefreshMovies({required this.category});

  @override
  List<Object?> get props => [category];
}
