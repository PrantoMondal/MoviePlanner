import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/paging/paging_bloc.dart';
import 'package:movie_planner/src/core/paging/paging_state.dart';

class HorizontalPagingSection<T> extends StatefulWidget {
  final String title;
  final ScrollController scrollController;
  final PagingBloc<T> pagingBloc;
  final VoidCallback loadData;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  const HorizontalPagingSection({
    super.key,
    required this.title,
    required this.scrollController,
    required this.pagingBloc,
    required this.loadData,
    required this.itemBuilder,
  });

  @override
  State<HorizontalPagingSection<T>> createState() => _HorizontalPagingSectionState<T>();
}

class _HorizontalPagingSectionState<T> extends State<HorizontalPagingSection<T>> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && widget.pagingBloc.canLoadNextPage()) {
      widget.loadData();
    }
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagingBloc<T>, PagingState<T>>(
      bloc: widget.pagingBloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            if (state.status == PagingStatus.loading && state.items.isEmpty)
              const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.status == PagingStatus.error && state.items.isEmpty)
              SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 8),
                      Text(state.errorMessage ?? 'Error loading data'),
                    ],
                  ),
                ),
              )
            else if (state.status == PagingStatus.empty)
              const SizedBox(height: 200, child: Center(child: Text('No items found')))
            else
              SizedBox(
                height: 240,
                child: ListView.builder(
                  controller: widget.scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount:
                      state.items.length + (state.status == PagingStatus.loading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.items.length) {
                      return const SizedBox(
                        width: 60,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return widget.itemBuilder(context, index, state.items[index]);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
