import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/stores/app_store/app_store.dart';
import '../core/stores/auth_store/auth_store.dart';
import '../features/dashboard/store/dashboard_store.dart';

class AppDependencyProvider extends StatelessWidget {
  const AppDependencyProvider({
    required this.child,
    required this.appStore,
    super.key,
  });

  final Widget child;
  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppStore>.value(value: appStore),
        Provider<AuthStore>(create: (_) => AuthStore()),
        Provider<DashboardStore>(create: (_) => DashboardStore()),
      ],
      child: child,
    );
  }
}
