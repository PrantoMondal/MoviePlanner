import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/base/base_widget_mixin.dart';
import 'package:movie_planner/src/core/base/paging_view.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';
import 'package:movie_planner/src/core/paging/paging_bloc.dart';
import 'package:movie_planner/src/core/paging/paging_state.dart';



class HorizontalPagingSection<T> extends StatelessWidget with BaseWidgetMixin {
  final ScrollController scrollController;
  final String title;
  final PagingBloc<T> pagingBloc;
  final void Function() loadData;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final double height;
  final String emptyText;

   HorizontalPagingSection({
    super.key,
    required this.scrollController,
    required this.title,
    required this.loadData,
    required this.itemBuilder,
    required this.pagingBloc,
    this.height = AppValues.container_280,
    this.emptyText = '(Empty)',
  });

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<PagingBloc<T>, PagingState<T>>(
      bloc: pagingBloc,
      builder: (context, state) {
        final items = state.items;
        final isEmpty = items.isEmpty && state.status != PagingStatus.loading;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: AppValues.gapSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: AppValues.gap),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              PagingView(
                scrollController: scrollController,
                scrollDirection: Axis.horizontal,
                loadData: loadData,
                bloc: pagingBloc,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: height,
                  ),
                  child: isEmpty
                      ? SizedBox(
                    height: AppValues.container_100,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        emptyText,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: AppValues.gap),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return itemBuilder(context, index, items[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: AppValues.gapSmall);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
