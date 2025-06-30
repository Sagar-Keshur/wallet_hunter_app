import 'package:flutter/material.dart';

import '../../../core/style_guide/style_guide.dart';

class NoMemberWidget extends StatelessWidget {
  const NoMemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.people_outline,
            size: 64,
            color: AppColors.iconsSecondary,
          ),
          const SizedBox(height: AppSpacing.spacingLg),
          Text(
            'No family members yet',
            style: AppStyles.h2.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.spacingSm),
          Text(
            'Add your first family member to get started',
            style: AppStyles.p1.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
