import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'core/stores/app_store/app_store.dart';
import 'core/style_guide/app_theme_data.dart';
import 'dependency_manager/app_dependency_provider.dart';
import 'dependency_manager/dependency_manager.dart';
import 'features/auth_guard/auth_guard_screen.dart';
import 'features/splash_screen/splash_screen.dart';
import 'router/main_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appStore = AppStore(dependencyManager: DependencyManager());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(_InterviewApp(store: appStore));
  });
}

class _InterviewApp extends StatelessWidget {
  const _InterviewApp({required this.store});

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (!store.initialized) {
          return const MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        }

        final mainRouter = getIt.get<MainRouter>();
        final mainRouteObserver = getIt.get<AppRouteObserver>();
        if (!kDebugMode) {
          FlutterError.onError = getIt
              .get<FirebaseCrashlytics>()
              .recordFlutterFatalError;
        }

        return AppDependencyProvider(
          appStore: store,
          child: MaterialApp(
            locale: const Locale('en', 'UK'),
            title: 'Interview Task',
            navigatorKey: mainRouter.key,
            navigatorObservers: [mainRouteObserver],
            onGenerateRoute: mainRouter.getRoute,
            debugShowCheckedModeBanner: false,
            theme: AppThemeData.theme,
            home: const AuthGuardScreen(),
          ),
        );
      },
    );
  }
}
