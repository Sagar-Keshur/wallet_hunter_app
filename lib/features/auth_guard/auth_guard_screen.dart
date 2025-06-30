import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/stores/auth_store/auth_store.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../dependency_manager/dependency_manager.dart';
import '../Authentication/authentication_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../onboarding/onboarding_screen.dart';

class AuthGuardScreen extends StatefulWidget {
  const AuthGuardScreen({super.key});

  @override
  State<AuthGuardScreen> createState() => _AuthGuardScreenState();
}

class _AuthGuardScreenState extends State<AuthGuardScreen> {
  late final AuthStore authStore;
  late final SharedPreferencesHelper sharedPreferencesHelper;
  late final bool isOnboardingCompleted;

  @override
  void initState() {
    authStore = context.read<AuthStore>();
    sharedPreferencesHelper = getIt<SharedPreferencesHelper>();
    isOnboardingCompleted = sharedPreferencesHelper.getBasicInfoState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (!authStore.isLoggedIn) {
          return const AuthenticationScreen();
        }
        if (isOnboardingCompleted) {
          return const DashboardScreen();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
