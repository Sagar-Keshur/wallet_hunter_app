import 'package:flutter/material.dart';

import '../../core/style_guide/style_guide.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.spacingLg),
          decoration: BoxDecoration(
            color: AppColors.familyPrimary,
            borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
          ),
          child: const Icon(
            Icons.family_restroom,
            color: AppColors.white,
            size: 60,
          ),
        ),
      ),
    );
  }
}
