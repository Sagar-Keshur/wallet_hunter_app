import 'package:flutter/material.dart';

import '../../../core/style_guide/style_guide.dart';

class FamilyHeadWidget extends StatelessWidget {
  const FamilyHeadWidget({
    required this.genderIcon,
    required this.name,
    required this.isFamilyHeadLoggedIn,
    required this.allMemberCount,
    super.key,
  });

  final String genderIcon;
  final String name;
  final bool isFamilyHeadLoggedIn;
  final int allMemberCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing2xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.familyPrimary,
            AppColors.familyPrimary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        boxShadow: [
          BoxShadow(
            color: AppColors.familyPrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(genderIcon, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: AppSpacing.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Welcome back,',
                        style: AppStyles.label1.copyWith(
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                    if (isFamilyHeadLoggedIn)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.spacingSm,
                          vertical: AppSpacing.spacingXs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMinimal,
                          ),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          'YOU',
                          style: AppStyles.label2.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.spacingSm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppStyles.h1.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.spacingSm),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusRound,
                        ),
                      ),
                      child: const Icon(
                        Icons.star,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.spacingSm),
                Text(
                  'Family Head • $allMemberCount members',
                  style: AppStyles.label1.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
