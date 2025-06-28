import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../features/splash_screen/splash_screen.dart';
import 'route_helper.dart';

class MainRouter implements AppRouter {
  @override
  String get name => 'main';

  static const String splashScreen = '/';

  final GlobalKey<NavigatorState> key = GlobalKey();

  final LinkedHashMap<String, RouteBuilder> routes =
      LinkedHashMap.from(<String, RouteBuilder>{
        splashScreen: ({settings}) {
          return _buildRoute(const SplashScreen(), settings: settings);
        },
      });

  /// The route being passed in [Navigator]'s onGenerateRoute
  Route getRoute(RouteSettings settings) {
    final route = routes[settings.name];
    assert(route != null, 'Route is not declared');
    return route!(settings: settings);
  }

  static Route<T> _buildRoute<T>(
    Widget child, {
    required RouteSettings? settings,
    bool fullScreenDialog = false,
  }) {
    return CupertinoPageRoute<T>(
      settings: settings,
      fullscreenDialog: fullScreenDialog,
      builder: (context) => child,
    );
  }
}

class RouteException implements Exception {
  const RouteException(this.message);

  final String message;
}

/// Should be inserted to every Navigators used in the app.
class AppRouteObserver extends RouteObserver {
  AppRouteObserver({required this.routerName});

  final String routerName;
  String? currentRoute;
  String? previousRoute;
  final List<String> routeStack = [];

  @override
  Future<void> didPush(Route route, Route? previousRoute) async {
    currentRoute = route.settings.name;
    this.previousRoute = previousRoute?.settings.name;
    routeStack.add(route.settings.name ?? 'Unknown');
    super.didPush(route, previousRoute);
  }

  @override
  Future<void> didPop(Route route, Route? previousRoute) async {
    routeStack.removeLast();
    this.previousRoute = route.settings.name;
    currentRoute = previousRoute?.settings.name;
    super.didPop(route, previousRoute);
  }

  @override
  Future<void> didReplace({Route? newRoute, Route? oldRoute}) async {
    if (newRoute is PageRoute) {
      routeStack
        ..removeLast()
        ..add(newRoute.settings.name ?? 'Unknown');
    }
    currentRoute = newRoute?.settings.name;
    previousRoute = oldRoute?.settings.name;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void setCurrentRoute({String? newRoute}) {
    if (currentRoute == null || currentRoute == '/') {
      currentRoute = newRoute;
    }
  }

  String? get previousRouteFromStack {
    return routeStack.length > 2 ? routeStack[routeStack.length - 3] : null;
  }

  String? get routeBeforeChats {
    for (int i = routeStack.length - 1; i >= 0; i--) {
      if (routeStack[i] != 'chat') {
        return routeStack[i];
      }
    }
    return null;
  }
}
