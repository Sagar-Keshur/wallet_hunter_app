import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/enum/state_type.dart';
import '../../../core/stores/auth_store/auth_store.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/widgets/widgets.dart';

class MobileNumberInputPage extends StatefulWidget {
  const MobileNumberInputPage({super.key});

  @override
  State<MobileNumberInputPage> createState() => _MobileNumberInputPageState();
}

class _MobileNumberInputPageState extends State<MobileNumberInputPage> {
  final TextEditingController _mobileController = TextEditingController();
  late AuthStore authStore;

  @override
  void initState() {
    super.initState();
    authStore = context.read<AuthStore>();
    _mobileController.text = authStore.mobileNumber;
  }

  Future<void> _onContinuePressed() async {
    FocusScope.of(context).unfocus();
    await authStore.sendOtp();
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
            const SizedBox(height: AppSpacing.spacing4xl),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spacingMd),
                  decoration: BoxDecoration(
                    color: AppColors.familyPrimary,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                  ),
                  child: const Icon(
                    Icons.family_restroom,
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
                        'Welcome to Family Wallet',
                        style: AppStyles.h1.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.spacingXs),
                      Text(
                        'Connect with your family members',
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
                    "Let's get started",
                    style: AppStyles.h2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingSm),
                  Text(
                    'Enter your mobile number to receive a verification code',
                    style: AppStyles.p1.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacing3xl),
                  AppTextField(
                    controller: _mobileController,
                    label: 'Mobile Number',
                    hintText: 'Enter your 10-digit mobile number',
                    keyboardType: TextInputType.phone,
                    leadingIcon: Icons.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _onContinuePressed(),
                    onChanged: (value) {
                      authStore.mobileNumber = value ?? '';
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spacing4xl),
            Observer(
              builder: (_) => AppButton(
                text: 'Send OTP',
                onPressed: _onContinuePressed,
                isLoading: authStore.sendOtpStatus.isLoading,
                isDisabled: !authStore.isMobileNumberValid,
              ),
            ),
            const SizedBox(height: AppSpacing.spacingLg),
            Center(
              child: Text(
                "Your family's financial journey starts here",
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
