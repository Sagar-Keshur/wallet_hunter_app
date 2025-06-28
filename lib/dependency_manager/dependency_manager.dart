import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/network/data_connection_checker.dart';
import '../core/services/network/network_info.dart';
import '../core/utils/api_helper.dart';
import '../core/utils/log_printer.dart';
import '../core/utils/shared_preferences_helper.dart';
import '../firebase_options.dart';
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

class DependencyManager {
  DependencyManager() {
    // Firebase
    provideFirebaseApp();
    provideFirebaseAuth();
    provideFirebaseCrashlytics();
    provideFirebaseAnalytics();

    // Utils
    provideLogger();
    provideDataConnectionChecker();
    provideNetworkInfo();
    provideMainRouter();
    provideRouteHelper();
    provideMainRouteObserver();
    provideFirestoreHelper();
    provideSharedPreferences();
    provideSharedPreferencesHelper();

    // Repositories
    // provideAuthenticationRepository();
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

  void provideFirebaseApp() {
    getIt.registerSingletonAsync<FirebaseApp>(() async {
      final FirebaseApp app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return app;
    });
  }

  void provideFirebaseAuth() {
    getIt.registerSingletonAsync<FirebaseAuth>(() async {
      await getIt.ensureReady<FirebaseApp>();
      await getIt.ensureReady<Logger>();
      final auth = FirebaseAuth.instance;
      return auth;
    });
  }

  void provideFirebaseCrashlytics() {
    getIt.registerSingletonAsync<FirebaseCrashlytics>(() async {
      await getIt.ensureReady<FirebaseApp>();
      final crashlytics = FirebaseCrashlytics.instance;
      return crashlytics;
    });
  }

  void provideFirebaseAnalytics() {
    getIt.registerSingletonAsync<FirebaseAnalytics>(() async {
      await getIt.ensureReady<FirebaseApp>();
      final analytics = FirebaseAnalytics.instance;
      await analytics.logAppOpen();
      return analytics;
    });
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

  void provideFirestoreHelper() {
    getIt.registerLazySingletonAsync<FirestoreHelper>(() async {
      await getIt.ensureReady<Logger>();
      await getIt.ensureReady<NetworkInfo>();
      return FirestoreHelper();
    });
  }

  void provideSharedPreferences() {
    getIt.registerSingletonAsync<SharedPreferences>(() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    });
  }

  // Services
  void provideSharedPreferencesHelper() {
    getIt.registerSingletonAsync<SharedPreferencesHelper>(() async {
      await getIt.ensureReady<SharedPreferences>();
      return SharedPreferencesHelper();
    });
  }

  // void provideAuthenticationRepository() {
  //   getIt.registerSingletonAsync<AuthenticationRepository>(() async {
  //     await getIt.ensureReady<FirebaseAuth>();
  //     await getIt.ensureReady<FirestoreHelper>();
  //     return AuthenticationRepositoryImpl();
  //   });
  // }
}
