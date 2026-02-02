import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/paging/paging_bloc.dart';
import 'package:movie_planner/src/core/paging/paging_state.dart';
import 'package:movie_planner/src/core/utils/loading.dart';


///ignore: must_be_immutable
class PagingView<T> extends StatefulWidget {
  final Widget child;
  final Function() loadData;
  final Future<void> Function()? onRefresh;
  final Axis scrollDirection;
  final PagingBloc<T> bloc;

  final ScrollController? scrollController;

  const PagingView({
    Key? key,
    required this.child,
    required this.loadData,
    required this.bloc,
    this.onRefresh,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  State<PagingView<T>> createState() => _PagingViewState<T>();
}

class _PagingViewState<T> extends State<PagingView<T>> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        0.85 * _scrollController.position.maxScrollExtent &&
        !_isLoadingMore &&
        widget.bloc.canLoadNextPage()) {
      _isLoadingMore = true;
      widget.loadData();
      Future.delayed(const Duration(milliseconds: 500), () {
        _isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagingBloc<T>, PagingState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        final isLoading = state.status == PagingStatus.loading;

        Widget scrollableView = SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: widget.scrollDirection,
          child: widget.child,
        );

        if (widget.onRefresh != null) {
          scrollableView = RefreshIndicator(
            onRefresh: widget.onRefresh!,
            child: scrollableView,
          );
        }

        return Stack(
          children: [
            scrollableView,
            if (isLoading)
              const Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Loading(),
              ),
          ],
        );
      },
    );
  }
}
