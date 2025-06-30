import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../core/utils/validation_mixin.dart';
import '../../../core/widgets/widgets.dart';
import '../store/onboarding_store.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({super.key});

  @override
  State<ContactInfoPage> createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage>
    with ValidationMixin {
  late OnboardingStore onboardingStore;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternativePhoneController = TextEditingController();
  final _landlineController = TextEditingController();
  final _socialMediaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    onboardingStore = context.read<OnboardingStore>();
    _initializeControllers();
  }

  void _initializeControllers() {
    _emailController.text = onboardingStore.emailId;
    _phoneController.text = onboardingStore.phoneNumber;
    _alternativePhoneController.text = onboardingStore.alternativeNumber;
    _landlineController.text = onboardingStore.landlineNumber;
    _socialMediaController.text = onboardingStore.socialMediaLink;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _alternativePhoneController.dispose();
    _landlineController.dispose();
    _socialMediaController.dispose();
    super.dispose();
  }

  void _onEmailChanged(String? value) {
    onboardingStore.emailId = value ?? '';
  }

  void _onPhoneChanged(String? value) {
    onboardingStore.phoneNumber = value ?? '';
  }

  void _onAlternativePhoneChanged(String? value) {
    onboardingStore.alternativeNumber = value ?? '';
  }

  void _onLandlineChanged(String? value) {
    onboardingStore.landlineNumber = value ?? '';
  }

  void _onSocialMediaChanged(String? value) {
    onboardingStore.socialMediaLink = value ?? '';
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
            Container(
              padding: const EdgeInsets.all(AppSpacing.spacing2xl),
              decoration: BoxDecoration(
                color: AppColors.bgSecondary,
                borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                border: Border.all(color: AppColors.borderDisabled),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: AppStyles.h2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacingSm),
                    Text(
                      'How can we reach you?',
                      style: AppStyles.p1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing3xl),
                    // Email ID
                    AppTextField(
                      controller: _emailController,
                      label: 'Email ID',
                      hintText: 'Enter your email address',
                      leadingIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _onEmailChanged,
                      validator: emailValidator,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Phone Number
                    AppTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hintText: 'Enter your phone number',
                      leadingIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: _onPhoneChanged,
                      validator: phoneValidator,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Alternative Number
                    AppTextField(
                      controller: _alternativePhoneController,
                      label: 'Alternative Number',
                      hintText: 'Enter alternative phone number',
                      leadingIcon: Icons.phone_android_outlined,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: _onAlternativePhoneChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Landline Number
                    AppTextField(
                      controller: _landlineController,
                      label: 'Landline Number',
                      hintText: 'Enter landline number',
                      leadingIcon: Icons.phone_in_talk_outlined,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(15),
                      ],
                      onChanged: _onLandlineChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Social Media Link
                    AppTextField(
                      controller: _socialMediaController,
                      label: 'Social Media Link',
                      hintText: 'Enter your social media profile link',
                      leadingIcon: Icons.link_outlined,
                      keyboardType: TextInputType.url,
                      onChanged: _onSocialMediaChanged,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.spacing4xl),
            Observer(
              builder: (_) => AppButton(
                text: 'Continue',
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    onboardingStore.onNextPage();
                    return;
                  }
                  SnackbarUtils.showErrorSnackBar(
                    'Please fill all required fields',
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.spacingLg),
            Center(
              child: Text(
                'Stay connected with your family',
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
