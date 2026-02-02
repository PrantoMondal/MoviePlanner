import 'package:equatable/equatable.dart';

enum PagingStatus { initial, loading, success, failure, empty }

class PagingState<T> extends Equatable {
  final List<T> items;
  final int pageNumber;
  final bool endOfList;
  final PagingStatus status;

  const PagingState({
    required this.items,
    required this.pageNumber,
    required this.endOfList,
    required this.status,
  });

  factory PagingState.initial() => PagingState(
    items: [],
    pageNumber: 1,
    endOfList: false,
    status: PagingStatus.initial,
  );

  PagingState<T> copyWith({
    List<T>? items,
    int? pageNumber,
    bool? endOfList,
    PagingStatus? status,
  }) {
    return PagingState<T>(
      items: items ?? this.items,
      pageNumber: pageNumber ?? this.pageNumber,
      endOfList: endOfList ?? this.endOfList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, pageNumber, endOfList, status];
}
