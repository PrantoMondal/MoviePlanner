import 'package:flutter_bloc/flutter_bloc.dart';
import 'paging_event.dart';
import 'paging_state.dart';

class PagingBloc<T> extends Bloc<PagingEvent<T>, PagingState<T>> {
  PagingBloc() : super(PagingState.initial()) {
    on<PagingRefresh<T>>(_onRefresh);
    on<PagingLoadNextPage<T>>(_onLoadNextPage);
    on<PagingLoadLastPage<T>>(_onLoadLastPage);
  }

  void _onRefresh(PagingRefresh<T> event, Emitter<PagingState<T>> emit) {
    emit(PagingState<T>.initial().copyWith(status: PagingStatus.loading));
  }

  void _onLoadNextPage(
      PagingLoadNextPage<T> event, Emitter<PagingState<T>> emit) {
    final currentItems = List<T>.from(state.items)..addAll(event.items);
    emit(state.copyWith(
      items: currentItems,
      pageNumber: state.pageNumber + 1,
      status: currentItems.isEmpty ? PagingStatus.empty : PagingStatus.success,
    ));
  }

  void _onLoadLastPage(
      PagingLoadLastPage<T> event, Emitter<PagingState<T>> emit) {
    final currentItems = List<T>.from(state.items)..addAll(event.items);
    emit(state.copyWith(
      items: currentItems,
      endOfList: true,
      status: PagingStatus.success,
    ));
  }

  bool canLoadNextPage() {
    return state.status != PagingStatus.loading && !state.endOfList;
  }
}
