import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/enum/state_type.dart';
import '../../../core/stores/auth_store/auth_store.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/widgets/widgets.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  late AuthStore authStore;

  @override
  void initState() {
    super.initState();
    authStore = context.read<AuthStore>();
  }

  void _onOtpCompleted(String otp) {
    authStore.otpCode = otp;
    if (otp.length == 6) {
      unawaited(_onVerifyPressed());
    }
  }

  Future<void> _onVerifyPressed() async {
    FocusScope.of(context).unfocus();
    await authStore.verifyOtp();
  }

  Future<void> _onResendPressed() async {
    await authStore.resendOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingMd),
                  decoration: BoxDecoration(
                    color: AppColors.familyPrimary,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                  ),
                  child: const Icon(
                    Icons.security,
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verify Your Number',
                        style: AppStyles.h1.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.spacingXs),
                      Text(
                        'Secure your family account',
                        style: AppStyles.p1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spacing4xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.spacing2xl),
              decoration: BoxDecoration(
                color: AppColors.bgSecondary,
                borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                border: Border.all(color: AppColors.borderDisabled),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Verification Code',
                    style: AppStyles.h2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingSm),
                  Observer(
                    builder: (_) => Text(
                      "We've sent a 6-digit code to ${authStore.formattedMobileNumber}",
                      style: AppStyles.p1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacing2xl),
                  OtpInputField(
                    length: 6,
                    onChanged: _onOtpCompleted,
                    onCompleted: _onOtpCompleted,
                    autofocus: true,
                    borderColor: AppColors.borderDisabled,
                    focusedBorderColor: AppColors.familyPrimary,
                    backgroundColor: AppColors.bgTertiary,
                    cursorColor: AppColors.familyPrimary,
                  ),
                  const SizedBox(height: AppSpacing.spacing3xl),
                  Observer(
                    builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!authStore.isResendTimerActive)
                          Text(
                            "Didn't receive the code? ",
                            style: AppStyles.label1.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        GestureDetector(
                          onTap:
                              authStore.canResendOtp &&
                                  !authStore.resendOtpStatus.isLoading
                              ? _onResendPressed
                              : null,
                          child: Text(
                            authStore.resendTimerText,
                            style: AppStyles.label1.copyWith(
                              color: authStore.canResendOtp
                                  ? AppColors.familyPrimary
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spacing4xl),
            Observer(
              builder: (_) => AppButton(
                text: 'Verify & Continue',
                onPressed: _onVerifyPressed,
                isLoading: authStore.verifyOtpStatus.isLoading,
                isDisabled: !authStore.isOtpComplete,
              ),
            ),
            const SizedBox(height: AppSpacing.spacingLg),
            Center(
              child: Text(
                "Your family's security is our priority",
                style: AppStyles.label1.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.spacing2xl),
          ],
        ),
      ),
    );
  }
}
