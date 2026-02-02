import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/injection_container.dart';
import 'package:movie_planner/src/core/routes/app_router.dart';
import 'package:movie_planner/src/core/theme/app_theme.dart';
import 'package:movie_planner/src/core/theme/theme_cubit.dart';
import 'package:movie_planner/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_planner/src/features/home/presentation/view/home_screen.dart';
import 'package:movie_planner/src/features/splash/presentation/view/splash_screen.dart';

import 'core/config/build_config.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final config = BuildConfig.instance.envConfig;

    return BlocProvider<ThemeCubit>(
      create: (_) => sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            title: config.appName,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light,

            routes: {
              Routes.splash: (_) => BlocProvider(create: (_) => sl<SplashBloc>(), child: SplashScreen()),
              Routes.home: (_) => BlocProvider(create: (_) => sl<HomeBloc>(), child: HomeScreen()),
            },
          );
        },
      ),
    );
  }
}
