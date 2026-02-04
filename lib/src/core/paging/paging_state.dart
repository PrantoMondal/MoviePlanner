enum PagingStatus { initial, loading, success, error, empty }

class PagingState<T> {
  final List<T> items;
  final int pageNumber;
  final bool endOfList;
  final PagingStatus status;
  final String? errorMessage;

  const PagingState({
    required this.items,
    required this.pageNumber,
    required this.endOfList,
    required this.status,
    this.errorMessage,
  });

  factory PagingState.initial() {
    return PagingState<T>(
      items: <T>[],
      pageNumber: 1,
      endOfList: false,
      status: PagingStatus.initial,
      errorMessage: null,
    );
  }
}
