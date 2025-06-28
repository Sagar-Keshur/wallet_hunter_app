import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/stores/auth_store/auth_store.dart';
import '../../core/widgets/widgets.dart';
import 'pages/mobile_number_input_page.dart';
import 'pages/verify_otp_page.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final AuthStore authStore;

  @override
  void initState() {
    super.initState();
    authStore = context.read<AuthStore>();
  }

  @override
  void dispose() {
    authStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return PopScope(
          canPop: authStore.currentPage == 0 ? true : false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              return;
            }
            await authStore.onBackPressed();
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Observer(
                builder: (_) {
                  if (authStore.currentPage == 0) {
                    return const SizedBox.shrink();
                  }
                  return AppAppBar(
                    leadingIcon: Icons.arrow_back_ios_new_rounded,
                    onLeadingIconPressed: authStore.onBackPressed,
                  );
                },
              ),
            ),

            body: SafeArea(
              child: PageView(
                controller: authStore.pageController,
                onPageChanged: (index) => authStore.currentPage = index,
                physics: const NeverScrollableScrollPhysics(),
                children: const [MobileNumberInputPage(), VerifyOtpPage()],
              ),
            ),
          ),
        );
      },
    );
  }
}
