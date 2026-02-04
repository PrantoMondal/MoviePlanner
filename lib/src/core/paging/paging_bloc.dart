import 'package:flutter_bloc/flutter_bloc.dart';
import 'paging_event.dart';
import 'paging_state.dart';

class PagingBloc<T> extends Bloc<PagingEvent<T>, PagingState<T>> {
  PagingBloc() : super(PagingState<T>.initial()) {
    on<PagingRefresh<T>>(_onRefresh);
    on<PagingLoadNextPage<T>>(_onLoadNextPage);
    on<PagingLoadLastPage<T>>(_onLoadLastPage);
    on<PagingError<T>>(_onError);
  }

  void _onRefresh(PagingRefresh<T> event, Emitter<PagingState<T>> emit) {
    emit(
      PagingState<T>(
        items: <T>[],
        pageNumber: 1,
        endOfList: false,
        status: PagingStatus.loading,
        errorMessage: null,
      ),
    );
  }

  void _onLoadNextPage(PagingLoadNextPage<T> event, Emitter<PagingState<T>> emit) {
    if (state.status == PagingStatus.loading) return;

    // Don't emit loading state here, just proceed
    final List<T> currentItems = <T>[...state.items, ...event.items];

    emit(
      PagingState<T>(
        items: currentItems,
        pageNumber: state.pageNumber + 1,
        endOfList: false,
        status: currentItems.isEmpty ? PagingStatus.empty : PagingStatus.success,
        errorMessage: null,
      ),
    );
  }

  void _onLoadLastPage(PagingLoadLastPage<T> event, Emitter<PagingState<T>> emit) {
    final List<T> currentItems = <T>[...state.items, ...event.items];

    emit(
      PagingState<T>(
        items: currentItems,
        pageNumber: state.pageNumber,
        endOfList: true,
        status: currentItems.isEmpty ? PagingStatus.empty : PagingStatus.success,
        errorMessage: null,
      ),
    );
  }

  void _onError(PagingError<T> event, Emitter<PagingState<T>> emit) {
    emit(
      PagingState<T>(
        items: state.items,
        pageNumber: state.pageNumber,
        endOfList: state.endOfList,
        status: PagingStatus.error,
        errorMessage: event.message,
      ),
    );
  }

  bool canLoadNextPage() {
    return state.status != PagingStatus.loading && !state.endOfList;
  }
}
