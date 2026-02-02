import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_planner/src/core/theme/theme_cubit.dart';

import 'src/features/home/presentation/bloc/home_bloc.dart';
import 'src/features/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // T H E M E
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());


  // D A T A   S O U R C E S
  // sl.registerLazySingleton<DeviceInfoDataSource>(() => DeviceInfoDataSource());
  // sl.registerLazySingleton<HistoryRemoteDataSource>(() => HistoryRemoteDataSource());
  // sl.registerLazySingleton<DeviceInfoRemoteDatasource>(
  //   () => DeviceInfoRemoteDatasource(),
  // );

  // R E P O S I T O R I E S
  // sl.registerLazySingleton<DeviceInfoRepository>(
  //   () => DeviceInfoRepositoryImpl(sl<DeviceInfoDataSource>()),
  // );
  // sl.registerLazySingleton<DeviceInfoRemoteRepository>(
  //   () => DeviceInfoRemoteRepositoryImpl(sl<DeviceInfoRemoteDatasource>()),
  // );
  // sl.registerLazySingleton<HistoryRepository>(
  //   () => HistoryRepositoryImpl(sl<HistoryRemoteDataSource>()),
  // );

  // U S E   C A S E S
  // sl.registerLazySingleton<GetDeviceInfo>(
  //   () => GetDeviceInfo(sl<DeviceInfoRepository>()),
  // );
  // sl.registerLazySingleton<LogStatus>(() => LogStatus(sl<DeviceInfoRemoteRepository>()));
  // sl.registerLazySingleton<GetHistory>(() => GetHistory(sl<HistoryRepository>()));
  // sl.registerLazySingleton<GetAnalytics>(() => GetAnalytics(sl<HistoryRepository>()));

  // B L O C K S
  sl.registerFactory<SplashBloc>(() => SplashBloc()..add(LoadSplash()));
  // sl.registerFactory<HomeBloc>(
  //   () =>
  //       HomeBloc(getDeviceInfo: sl<GetDeviceInfo>(), logStatus: sl<LogStatus>())
  //         ..add(const LoadHomeData()),
  // );
  sl.registerFactory<HomeBloc>(() => HomeBloc());
  // sl.registerFactory<HistoryBloc>(
  //   () => HistoryBloc(getHistory: sl<GetHistory>(), getAnalytics: sl<GetAnalytics>())
  //     ..add(const LoadHistory())
  //     ..add(const LoadAnalytics()),
  // );

  // D I O
  sl.registerLazySingleton<Dio>(() => Dio());
}
