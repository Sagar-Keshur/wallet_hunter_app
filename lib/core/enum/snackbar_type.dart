import 'package:flutter/material.dart';

import '../style_guide/style_guide.dart';

enum SnackbarType { info, error, success }

extension SnackbarTypeExtension on SnackbarType {
  Color get color {
    switch (this) {
      case SnackbarType.info:
        return AppColors.familySecondary;
      case SnackbarType.error:
        return AppColors.familyError;
      case SnackbarType.success:
        return AppColors.familySuccess;
    }
  }
}
