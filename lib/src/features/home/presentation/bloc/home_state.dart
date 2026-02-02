part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends BaseState {
  final HomeStatus status;

  const HomeState({
    this.status = HomeStatus.initial,
  });

  HomeState copyWith({
    HomeStatus? status,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }

  bool get isInitial => status == HomeStatus.initial;
  bool get isLoading => status == HomeStatus.loading;
  bool get isSuccess => status == HomeStatus.success;
  bool get isFailure => status == HomeStatus.failure;

  @override
  List<Object?> get props => [status];
}
