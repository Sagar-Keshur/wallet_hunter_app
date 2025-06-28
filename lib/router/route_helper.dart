import 'dart:async';

import 'package:flutter/material.dart';

import '../dependency_manager/dependency_manager.dart';
import 'main_router.dart';

typedef RouteBuilder = Route<dynamic> Function({RouteSettings? settings});

abstract class AppRouter {
  String get name;
}

class RouteHelper {
  MainRouter get mainRouter => getIt<MainRouter>();

  BuildContext get context => mainRouter.key.currentContext!;

  void pop<T>([T? result]) {
    mainRouter.key.currentState?.pop(result);
  }

  void popUntil(String routeName) {
    mainRouter.key.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  void showAuthGuardScreenAndRemoveEverything() {
    unawaited(
      mainRouter.key.currentState?.pushNamedAndRemoveUntil(
        MainRouter.authGuardScreen,
        (route) => false,
      ),
    );
  }
}
