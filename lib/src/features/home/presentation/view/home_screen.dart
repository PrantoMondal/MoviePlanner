import 'package:movie_planner/src/core/base/base_view.dart';
import 'package:movie_planner/src/core/constants/app_colors.dart';
import 'package:movie_planner/src/core/theme/theme_cubit.dart';
import 'package:movie_planner/src/core/utils/application_bar.dart';
import 'package:movie_planner/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends BaseView<HomeBloc, HomeState> {
  HomeScreen({super.key});

  @override
  bool isLoading(HomeState state) => state.isLoading;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return ApplicationBar(appTitleText: 'Movie Planner',);
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // Static UI: handle loading, success, failure states
        if (state.isFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: AppColors.errorColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load data',
                  style: const TextStyle(fontSize: 18, color: AppColors.errorColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

              ],
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SwitchListTile(
                title: Text('Dark Mode',style: Theme.of(context).textTheme.titleLarge,),
                value: context.watch<ThemeCubit>().state == AppThemeMode.dark,
                onChanged: (_) {
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
            ),

          ],
        );
      },
    );
  }
}
