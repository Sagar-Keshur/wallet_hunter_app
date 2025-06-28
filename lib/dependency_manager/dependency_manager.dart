import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../core/services/network/data_connection_checker.dart';
import '../core/services/network/network_info.dart';
import '../core/utils/api_helper.dart';
import '../core/utils/log_printer.dart';
import '../router/main_router.dart';
import '../router/route_helper.dart';

GetIt getIt = GetIt.I;

extension GetItExtension on GetIt {
  Future<void> ensureReady<T extends Object>() async {
    try {
      await isReady<T>();
    } on Exception catch (e) {
      debugPrint('ensureReady caught exception $e');
    }
  }
}

/// Central and top level location of dependencies. Subclasses of this can be
/// considered as different environment with configurable/override-able
/// dependencies.
class DependencyManager {
  /// Defines dependency provision in any order. Each provision may wait for any
  /// needed async dependency. This way, circular dependencies are easy to
  /// deal with.
  DependencyManager() {
    // Setup dependencies
    provideLogger();
    provideDataConnectionChecker();
    provideNetworkInfo();

    provideMainRouter();
    provideRouteHelper();
    provideMainRouteObserver();

    // Setup services
    provideApiHelper();

    // Repositories
  }

  bool initialized = false;

  Future<void> init() async {
    await getIt.allReady();
    initialized = true;
  }

  Future<void> dispose() async {
    await getIt.reset();
  }

  void provideMainRouter() {
    getIt.registerLazySingleton<MainRouter>(MainRouter.new);
  }

  void provideRouteHelper() {
    getIt.registerLazySingleton<RouteHelper>(RouteHelper.new);
  }

  void provideMainRouteObserver() {
    getIt.registerLazySingleton<AppRouteObserver>(
      () => AppRouteObserver(routerName: MainRouter().name),
    );
  }

  void provideLogger() {
    getIt.registerLazySingletonAsync<Logger>(
      () async => Logger(printer: AppLogPrinter()),
    );
  }

  void provideDataConnectionChecker() {
    getIt.registerLazySingleton<DataConnectionChecker>(
      DataConnectionChecker.new,
    );
  }

  void provideNetworkInfo() {
    getIt.registerLazySingletonAsync<NetworkInfo>(() async => NetworkInfo());
  }

  void provideApiHelper() {
    getIt.registerLazySingletonAsync<ApiHelper>(() async {
      await getIt.ensureReady<Logger>();
      await getIt.ensureReady<NetworkInfo>();
      return ApiHelper();
    });
  }
}
