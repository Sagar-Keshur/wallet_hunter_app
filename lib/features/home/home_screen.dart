import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/stores/app_store/app_store.dart';
import '../../core/stores/auth_store/auth_store.dart';
import '../Authentication/authentication_screen.dart';
import '../dashboard/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthStore authStore;
  late final AppStore appStore;
  bool _isLoggedIn = false;

  @override
  void initState() {
    authStore = context.read<AuthStore>();
    appStore = context.read<AppStore>();
    _isLoggedIn = authStore.getLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_isLoggedIn) {
          return const DashboardScreen();
        } else {
          return const AuthenticationScreen();
        }
      },
    );
  }
}
