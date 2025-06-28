import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/stores/auth_store/auth_store.dart';
import '../Authentication/authentication_screen.dart';
import '../dashboard/dashboard_screen.dart';

class AuthGuardScreen extends StatefulWidget {
  const AuthGuardScreen({super.key});

  @override
  State<AuthGuardScreen> createState() => _AuthGuardScreenState();
}

class _AuthGuardScreenState extends State<AuthGuardScreen> {
  late final AuthStore authStore;

  @override
  void initState() {
    authStore = context.read<AuthStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (authStore.isLoggedIn) {
          return const DashboardScreen();
        } else {
          return const AuthenticationScreen();
        }
      },
    );
  }
}
