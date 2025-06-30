import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/style_guide/style_guide.dart';
import '../../core/widgets/widgets.dart';
import '../dashboard/store/dashboard_store.dart';
import 'pages/address_page.dart';
import 'pages/contact_info_page.dart';
import 'pages/member_summary_page.dart';
import 'pages/native_place_page.dart';
import 'pages/personal_info_page.dart';
import 'store/add_member_store.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AddMemberStore>(
          create: (_) {
            return AddMemberStore(
              dashboardStore: context.read<DashboardStore>(),
            );
          },
        ),
      ],
      child: const _AddMemberScreenImpl(),
    );
  }
}

class _AddMemberScreenImpl extends StatefulWidget {
  const _AddMemberScreenImpl();

  @override
  State<_AddMemberScreenImpl> createState() => _AddMemberScreenImplState();
}

class _AddMemberScreenImplState extends State<_AddMemberScreenImpl> {
  late final AddMemberStore addMemberStore;

  @override
  void initState() {
    super.initState();
    addMemberStore = context.read<AddMemberStore>();
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
        addMemberStore.onBackPressed();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppAppBar(
            leadingIcon: Icons.arrow_back_ios_new_rounded,
            onLeadingIconPressed: addMemberStore.onBackPressed,
            titleWidget: _buildTitleWidget(),
            actions: [
              Observer(
                builder: (_) {
                  return Text(
                    '${addMemberStore.currentPage + 1}/${addMemberStore.totalPages}',
                    style: AppStyles.b1.copyWith(fontWeight: FontWeight.w600),
                  );
                },
              ),
            ],
          ),
        ),
        body: PageView(
          controller: addMemberStore.pageController,
          onPageChanged: (index) {
            addMemberStore.currentPage = index;
          },
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            PersonalInfoPage(),
            ContactInfoPage(),
            AddressPage(),
            NativePlacePage(),
            MemberSummaryPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Observer(
      builder: (context) {
        switch (addMemberStore.currentPage) {
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
                        'Tell us about the family member',
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
                        'How can we reach them?',
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
                      const Text('Current Address', style: AppStyles.h6),
                      const SizedBox(height: AppSpacing.spacingHalf),
                      Text(
                        'Where do they live?',
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
                    Icons.home,
                    color: AppColors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Native Place', style: AppStyles.h6),
                      const SizedBox(height: AppSpacing.spacingHalf),
                      Text(
                        'Where are they from?',
                        style: AppStyles.p1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          case 4:
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
                      const Text('Member Summary', style: AppStyles.h6),
                      const SizedBox(height: AppSpacing.spacingHalf),
                      Text(
                        'Review all information',
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
