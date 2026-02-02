import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/base/base_view.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';
import 'package:movie_planner/src/core/constants/app_values.dart';
import 'package:movie_planner/src/core/theme/theme_cubit.dart';
import 'package:movie_planner/src/core/utils/application_bar.dart';
import 'package:movie_planner/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_planner/src/features/home/presentation/widgets/movie_card.dart';

class HomeScreen extends BaseView<HomeBloc, HomeState> {
  HomeScreen({super.key});

  @override
  bool isLoading(HomeState state) => state.isLoading;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return ApplicationBar(
      appTitleText: 'Movie Planner',
      actions: [
        IconButton(
          icon: Icon(context.watch<ThemeCubit>().state == AppThemeMode.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                padding: EdgeInsets.all(AppValues.gap),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  // mainAxisExtent: 300,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) => MovieCard(onTap: () {}),
              ),
            ],
          ),
        );
      },
    );
  }
}
