import 'package:flutter/material.dart';

import '../style_guide/style_guide.dart';

enum ButtonType {
  primary,
  primaryLarge,
  primarySmall,
  secondary,
  secondaryWithOutBg,
  secondarySmall,
  tertiary,
  tertiarySmall,
  delete,
}

extension ButtonTypeExtension on ButtonType {
  Color getButtonColor(BuildContext context) {
    switch (this) {
      case ButtonType.primary:
      case ButtonType.primarySmall:
      case ButtonType.primaryLarge:
        return AppColors.buttonPrimary;
      case ButtonType.secondaryWithOutBg:
      case ButtonType.secondary:
      case ButtonType.secondarySmall:
        return Colors.transparent;
      case ButtonType.tertiary:
      case ButtonType.tertiarySmall:
        return AppColors.buttonPrimary;
      case ButtonType.delete:
        return AppColors.red100;
    }
  }

  Color getTextColor(BuildContext context) {
    switch (this) {
      case ButtonType.primary:
      case ButtonType.primaryLarge:
      case ButtonType.primarySmall:
      case ButtonType.tertiary:
      case ButtonType.tertiarySmall:
        return AppColors.textButtonDefault;
      case ButtonType.secondary:
      case ButtonType.secondaryWithOutBg:
      case ButtonType.secondarySmall:
        return AppColors.textButtonSecondary;
      case ButtonType.delete:
        return AppColors.natural100;
    }
  }

  Color getIconColor(BuildContext context) {
    switch (this) {
      case ButtonType.primary:
      case ButtonType.primaryLarge:
      case ButtonType.primarySmall:
      case ButtonType.tertiary:
      case ButtonType.tertiarySmall:
        return AppColors.textButtonDefault;
      case ButtonType.secondary:
      case ButtonType.secondaryWithOutBg:
      case ButtonType.secondarySmall:
        return AppColors.textButtonSecondary;
      case ButtonType.delete:
        return AppColors.natural100;
    }
  }

  TextStyle getButtonTextStyle(BuildContext context) {
    switch (this) {
      case ButtonType.primary:
      case ButtonType.secondary:
      case ButtonType.secondaryWithOutBg:
      case ButtonType.tertiary:
      case ButtonType.primaryLarge:
      case ButtonType.primarySmall:
      case ButtonType.tertiarySmall:
      case ButtonType.secondarySmall:
      case ButtonType.delete:
        return AppStyles.b3;
    }
  }

  Color getDisabledButtonColor(BuildContext context) {
    switch (this) {
      case ButtonType.primary:
      case ButtonType.primaryLarge:
      case ButtonType.primarySmall:
      case ButtonType.tertiary:
      case ButtonType.tertiarySmall:
      case ButtonType.secondary:
      case ButtonType.secondaryWithOutBg:
      case ButtonType.secondarySmall:
      case ButtonType.delete:
        return AppColors.buttonDisabled;
    }
  }

  Border? getBorder(BuildContext context) {
    if (this == ButtonType.secondary || this == ButtonType.secondarySmall) {
      return Border.all(color: AppColors.white);
    }
    return null;
  }
}
