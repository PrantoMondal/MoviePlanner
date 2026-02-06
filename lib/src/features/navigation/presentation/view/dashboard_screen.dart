import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/injection_container.dart';
import 'package:movie_planner/src/core/base/base_view.dart';
import 'package:movie_planner/src/core/utils/extensions.dart';
import 'package:movie_planner/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_planner/src/features/navigation/presentation/bloc/nav_cubit.dart';
import 'package:movie_planner/src/features/navigation/presentation/widgets/app_bottom_nav_bar.dart';

class DashboardScreen extends BaseView<NavCubit, NavState> {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>(),
      child: super.build(context),
    );
  }

  @override
  Widget body(BuildContext context) {
    final cubit = context.read<NavCubit>();
    final state = context.watch<NavCubit>().state;

    return IndexedStack(
      index: state.navIndex,
      children: cubit.pages,
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return Builder(
      builder: (context) {
        final state = context.watch<NavCubit>().state;

        return AppBottomNavBar(
          currentIndex: state.navIndex,
          onTap: (index) {
            context.read<NavCubit>().changeNavigationIndex(index);
          },
        );
      },
    );
  }

  @override
  bool resizeToAvoidBottomInset() => false;

  @override
  Widget annotatedRegion(BuildContext context, NavState state) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: context.theme.appBarTheme.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Material(
        color: Colors.transparent,
        child: pageScaffold(context, state),
      ),
    );
  }
}