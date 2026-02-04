import 'package:movie_planner/src/application.dart';
import 'package:movie_planner/src/core/config/env_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'injection_container.dart';
import 'src/core/config/build_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final envConfig = EnvConfig(
    appName: packageInfo.appName,
    appVersion: packageInfo.version,
    packageName: packageInfo.packageName,
    baseUrl: "https://api.themoviedb.org/3",
  );

  BuildConfig.instantiate(config: envConfig);
  await setupDependencies();
  runApp(MediaQuery.withNoTextScaling(child: const Application()));
}
