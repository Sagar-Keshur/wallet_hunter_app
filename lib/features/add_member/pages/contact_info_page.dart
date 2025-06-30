import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../core/utils/validation_mixin.dart';
import '../../../core/widgets/widgets.dart';
import '../store/add_member_store.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({super.key});

  @override
  State<ContactInfoPage> createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage>
    with ValidationMixin {
  late AddMemberStore addMemberStore;
  final _phoneNumberController = TextEditingController();
  final _alternativeNumberController = TextEditingController();
  final _landlineNumberController = TextEditingController();
  final _emailIdController = TextEditingController();
  final _socialMediaLinkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addMemberStore = context.read<AddMemberStore>();
    _initializeControllers();
  }

  void _initializeControllers() {
    _phoneNumberController.text = addMemberStore.phoneNumber;
    _alternativeNumberController.text = addMemberStore.alternativeNumber;
    _landlineNumberController.text = addMemberStore.landlineNumber;
    _emailIdController.text = addMemberStore.emailId;
    _socialMediaLinkController.text = addMemberStore.socialMediaLink;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _alternativeNumberController.dispose();
    _landlineNumberController.dispose();
    _emailIdController.dispose();
    _socialMediaLinkController.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged(String? value) {
    addMemberStore.phoneNumber = value ?? '';
  }

  void _onAlternativeNumberChanged(String? value) {
    addMemberStore.alternativeNumber = value ?? '';
  }

  void _onLandlineNumberChanged(String? value) {
    addMemberStore.landlineNumber = value ?? '';
  }

  void _onEmailIdChanged(String? value) {
    addMemberStore.emailId = value ?? '';
  }

  void _onSocialMediaLinkChanged(String? value) {
    addMemberStore.socialMediaLink = value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMargin,
        ),
        child: Form(
          key: _formKey,
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
                    const SizedBox(height: AppSpacing.spacing3xl),

                    // Phone Number
                    AppTextField(
                      controller: _phoneNumberController,
                      label: 'Phone Number',
                      hintText: 'Enter phone number',
                      leadingIcon: Icons.phone_outlined,
                      onChanged: _onPhoneNumberChanged,
                      validator: phoneValidator,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Alternative Number
                    AppTextField(
                      controller: _alternativeNumberController,
                      label: 'Alternative Number',
                      hintText: 'Enter alternative number (optional)',
                      leadingIcon: Icons.phone_outlined,
                      onChanged: _onAlternativeNumberChanged,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Landline Number
                    AppTextField(
                      controller: _landlineNumberController,
                      label: 'Landline Number',
                      hintText: 'Enter landline number (optional)',
                      leadingIcon: Icons.phone_outlined,
                      onChanged: _onLandlineNumberChanged,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Email ID
                    AppTextField(
                      controller: _emailIdController,
                      label: 'Email ID',
                      hintText: 'Enter email address',
                      leadingIcon: Icons.email_outlined,
                      onChanged: _onEmailIdChanged,
                      validator: emailValidator,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Social Media Link
                    AppTextField(
                      controller: _socialMediaLinkController,
                      label: 'Social Media Link',
                      hintText: 'Enter social media profile link (optional)',
                      leadingIcon: Icons.link_outlined,
                      onChanged: _onSocialMediaLinkChanged,
                      keyboardType: TextInputType.url,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.spacing4xl),
              Observer(
                builder: (_) => AppButton(
                  text: 'Continue',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      addMemberStore.onNextPage();
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
                  'Adding family member to your profile',
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
      ),
    );
  }
}
