import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  final bool isLoading;
  final String? error;

  const BaseState({
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [isLoading, error];
}
