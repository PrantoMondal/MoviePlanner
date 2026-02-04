abstract class PagingEvent<T> {
  const PagingEvent();
}

class PagingRefresh<T> extends PagingEvent<T> {
  const PagingRefresh();
}

class PagingLoadNextPage<T> extends PagingEvent<T> {
  final List<T> items;

  const PagingLoadNextPage({required this.items});
}

class PagingLoadLastPage<T> extends PagingEvent<T> {
  final List<T> items;

  const PagingLoadLastPage({required this.items});
}

class PagingError<T> extends PagingEvent<T> {
  final String message;

  const PagingError({required this.message});
}
