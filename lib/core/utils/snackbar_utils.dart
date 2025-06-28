import 'package:flutter/material.dart';

import '../../dependency_manager/dependency_manager.dart';
import '../../router/route_helper.dart';
import '../style_guide/style_guide.dart';

class SnackbarUtils {
  SnackbarUtils._();

  static final currentState =
      getIt<RouteHelper>().mainRouter.key.currentState?.overlay?.context;

  static void hideCurrentSnackBar() {
    if (currentState == null) {
      return;
    }

    ScaffoldMessenger.of(currentState!).hideCurrentSnackBar();
  }

  static void showErrorSnackBar(String message) {
    if (currentState == null) {
      return;
    }

    hideCurrentSnackBar();
    ScaffoldMessenger.of(currentState!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMinimal),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingComfortable,
          vertical: AppSpacing.paddingComfortable,
        ),
        content: Text(
          message,
          style: AppStyles.p1,
        ),
        backgroundColor: Colors.red.withAlpha(200),
      ),
    );
  }

  static void showSuccessSnackBar(String message) {
    if (currentState == null) {
      return;
    }

    hideCurrentSnackBar();
    ScaffoldMessenger.of(currentState!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMinimal),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingComfortable,
          vertical: AppSpacing.paddingComfortable,
        ),
        content: Text(
          message,
          style: AppStyles.p1,
        ),
        backgroundColor: AppColors.buttonSecondary,
      ),
    );
  }
}
