import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/style_guide/style_guide.dart';
import '../../core/utils/context_extension.dart';
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
          child: Observer(
            builder: (_) {
              return AppAppBar(
                leadingIcon: Icons.arrow_back_rounded,
                onLeadingIconPressed: onboardingStore.onBackPressed,
              );
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingMargin,
                vertical: AppSpacing.paddingCompressed,
              ).copyWith(
                bottom: context.bottomPadding(AppSpacing.paddingCompressed),
              ),
          child: Observer(
            builder: (_) {
              return  const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Observer(
                  //   builder: (_) {
                  //     return AppButton(
                  //       text: 'Continue',
                  //       isLoading: onboardingStore.onboardingStatus.isLoading,
                  //       isDisabled: onboardingStore.isDisabled,
                  //       onPressed: onboardingStore.onContinue,
                  //     );
                  //   },
                  // ),
                ],
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.paddingMargin,
          ),
          child: Column(
            children: [
              Observer(
                builder: (_) {
                  return const AppProgressBar(value: 0.5);
                },
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(4),
                    ),
                  ),
                  child: PageView(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
