import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_planner/src/core/theme/theme_cubit.dart';
import 'package:movie_planner/src/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:movie_planner/src/features/home/data/repositories/movie_remote_repo_impl.dart';
import 'package:movie_planner/src/features/home/domain/repositories/movie_remote_repo.dart';
import 'package:movie_planner/src/features/home/domain/usecases/get_movies_usecase.dart';
import 'package:movie_planner/src/features/home/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_planner/src/features/home/domain/usecases/get_upcoming_movies_usecase.dart';

import 'src/features/home/presentation/bloc/home_bloc.dart';
import 'src/features/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // T H E M E
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // D I O
  sl.registerLazySingleton<Dio>(() => Dio());

  // D A T A   S O U R C E S
  sl.registerLazySingleton<MovieRemoteDatasource>(() => MovieRemoteDatasource());

  // R E P O S I T O R I E S
  sl.registerLazySingleton<MovieRemoteRepo>(
    () => MovieRemoteRepoImpl(sl<MovieRemoteDatasource>()),
  );

  // U S E   C A S E S
  sl.registerLazySingleton<GetMoviesUseCase>(
    () => GetMoviesUseCase(sl<MovieRemoteRepo>()),
  );
  // sl.registerLazySingleton<GetPopularMoviesUseCase>(
  //   () => GetPopularMoviesUseCase(sl<MovieRemoteRepo>()),
  // );

  // sl.registerLazySingleton<GetTopRatedMoviesUseCase>(
  //       () => GetTopRatedMoviesUseCase(sl<MovieRemoteRepo>()),
  // );

  // sl.registerLazySingleton<GetUpcomingMoviesUseCase>(
  //   () => GetUpcomingMoviesUseCase(sl<MovieRemoteRepo>()),
  // );

  // B L O C S
  sl.registerFactory<SplashBloc>(() => SplashBloc()..add(LoadSplash()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(sl<GetMoviesUseCase>()));
}
