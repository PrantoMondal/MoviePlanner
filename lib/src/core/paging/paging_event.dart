import 'package:equatable/equatable.dart';

abstract class PagingEvent<T> extends Equatable {
  const PagingEvent();

  @override
  List<Object?> get props => [];
}

class PagingRefresh<T> extends PagingEvent<T> {}

class PagingLoadNextPage<T> extends PagingEvent<T> {
  final List<T> items;

  const PagingLoadNextPage(this.items);

  @override
  List<Object?> get props => [items];
}

class PagingLoadLastPage<T> extends PagingEvent<T> {
  final List<T> items;

  const PagingLoadLastPage(this.items);

  @override
  List<Object?> get props => [items];
}
