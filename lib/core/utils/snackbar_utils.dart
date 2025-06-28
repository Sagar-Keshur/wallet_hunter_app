import 'package:flutter/material.dart';

import '../../dependency_manager/dependency_manager.dart';
import '../../router/route_helper.dart';
import '../enum/snackbar_type.dart';
import '../style_guide/style_guide.dart';

class SnackbarUtils {
  SnackbarUtils._();

  static final currentState =
      getIt<RouteHelper>().mainRouter.key.currentState!.overlay!.context;

  static void hideCurrentSnackBar() {
    ScaffoldMessenger.of(currentState).hideCurrentSnackBar();
  }

  static void _buildSnackBar({
    required String message,
    required SnackbarType type,
  }) {
    ScaffoldMessenger.of(currentState).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusNormal),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingComfortable,
          vertical: AppSpacing.paddingComfortable,
        ),
        content: Text(
          message,
          style: AppStyles.b3.copyWith(color: AppColors.white),
        ),
        backgroundColor: type.color,
      ),
    );
  }

  static void showInfoSnackBar(String message) {
    hideCurrentSnackBar();
    _buildSnackBar(message: message, type: SnackbarType.info);
  }

  static void showErrorSnackBar(String message) {
    hideCurrentSnackBar();
    _buildSnackBar(message: message, type: SnackbarType.error);
  }

  static void showSuccessSnackBar(String message) {
    hideCurrentSnackBar();
    _buildSnackBar(message: message, type: SnackbarType.success);
  }
}
