import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../dependency_manager/dependency_manager.dart';
import '../../../router/route_helper.dart';
import '../style_guide/style_guide.dart';
import '../utils/context_extension.dart';
import 'widgets.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({
    required this.permissionType,
    required this.title,
    required this.description,
    super.key,
  });

  final String permissionType;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: context.bottomPadding(24),
      ),
      alignment: Alignment.bottomCenter,
      backgroundColor: AppColors.bgPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Settings', style: AppStyles.h3),
                Text(
                  title,
                  style: AppStyles.label1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spacingMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingComfortable,
              vertical: AppSpacing.paddingCompact,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderDisabled),
              color: AppColors.bgNegative,
            ),
            child: Text(description, style: AppStyles.p1),
          ),
          const SizedBox(height: 12),
          AppButton(
            text: 'Open permission settings',
            onPressed: () async {
              await openAppSettings();
              getIt<RouteHelper>().pop();
            },
          ),
        ],
      ),
    );
  }
}
