import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/style_guide/style_guide.dart';
import '../../core/widgets/widgets.dart';
import 'pages/address_page.dart';
import 'pages/contact_info_page.dart';
import 'pages/personal_info_page.dart';
import 'pages/profile_summary_page.dart';
import 'store/onboarding_store.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<OnboardingStore>(create: (_) => OnboardingStore())],
      child: const _OnboardingScreenImpl(),
    );
  }
}

class _OnboardingScreenImpl extends StatefulWidget {
  const _OnboardingScreenImpl();

  @override
  State<_OnboardingScreenImpl> createState() => _OnboardingScreenImplState();
}

class _OnboardingScreenImplState extends State<_OnboardingScreenImpl> {
  late final OnboardingStore onboardingStore;

  @override
  void initState() {
    super.initState();
    onboardingStore = context.read<OnboardingStore>();
    // getIt<Mixpanel>().timeEvent(TimeSpentOnOnboardingFlowEvent().name);
    // unawaited(analytics.maybeTrack(OnboardingStartedEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        onboardingStore.onBackPressed();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppAppBar(
            leadingIcon: Icons.arrow_back_ios_new_rounded,
            onLeadingIconPressed: onboardingStore.onBackPressed,
            titleWidget: _buildTitleWidget(),
            actions: [
              Observer(
                builder: (_) {
                  return Text(
                    '${onboardingStore.currentPage + 1}/${onboardingStore.totalPages}',
                    style: AppStyles.b1.copyWith(fontWeight: FontWeight.w600),
                  );
                },
              ),
            ],
          ),
        ),
        body: PageView(
          controller: onboardingStore.pageController,
          onPageChanged: (index) {
            onboardingStore.currentPage = index;
          },
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            PersonalInfoPage(),
            ContactInfoPage(),
            AddressPage(),
            ProfileSummaryPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Observer(
      builder: (context) {
        switch (onboardingStore.currentPage) {
          case 0:
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingSm),
                  decoration: BoxDecoration(
                    color: AppColors.familyPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Personal Information', style: AppStyles.h6),
                      const SizedBox(height: AppSpacing.spacingHalf),
                      Text(
                        'Tell us about yourself',
                        style: AppStyles.p1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          case 1:
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingSm),
                  decoration: BoxDecoration(
                    color: AppColors.familyPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.contact_phone,
                    color: AppColors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Contact Information', style: AppStyles.h6),
                      const SizedBox(height: AppSpacing.spacingHalf),
                      Text(
                        'How can we reach you?',
                        style: AppStyles.p1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          case 2:
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingSm),
                  decoration: BoxDecoration(
                    color: AppColors.familyPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Address Information', style: AppStyles.h6),
                      const SizedBox(height: AppSpacing.spacingHalf),
                      Text(
                        'Where do you live?',
                        style: AppStyles.p1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          case 3:
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingSm),
                  decoration: BoxDecoration(
                    color: AppColors.familyPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.summarize,
                    color: AppColors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Profile Summary', style: AppStyles.h6),
                      const SizedBox(height: AppSpacing.spacingHalf),
                      Text(
                        'Review your information',
                        style: AppStyles.p1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
