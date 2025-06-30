import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/enum/state_type.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/widgets/widgets.dart';
import '../store/onboarding_store.dart';

class ProfileSummaryPage extends StatefulWidget {
  const ProfileSummaryPage({super.key});

  @override
  State<ProfileSummaryPage> createState() => _ProfileSummaryPageState();
}

class _ProfileSummaryPageState extends State<ProfileSummaryPage> {
  late OnboardingStore onboardingStore;

  @override
  void initState() {
    super.initState();
    onboardingStore = context.read<OnboardingStore>();
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Not provided';
    }
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Summary',
                    style: AppStyles.h2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingSm),
                  Text(
                    'Review your information before submitting',
                    style: AppStyles.p1.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacing3xl),

                  // Personal Information Section
                  _buildSectionHeader('Personal Information', Icons.person),
                  const SizedBox(height: AppSpacing.spacing2xl),

                  Observer(
                    builder: (_) => Column(
                      children: [
                        _buildSummaryItem('Name', onboardingStore.name),
                        _buildSummaryItem(
                          'Age',
                          onboardingStore.age > 0
                              ? onboardingStore.age.toString()
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Birth Date',
                          _formatDate(onboardingStore.birthDate),
                        ),
                        _buildSummaryItem(
                          'Blood Group',
                          onboardingStore.bloodGroup.isNotEmpty
                              ? onboardingStore.bloodGroup
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Gender',
                          onboardingStore.gender?.displayName ?? 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Marital Status',
                          onboardingStore.maritalStatus.isNotEmpty
                              ? onboardingStore.maritalStatus
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Occupation',
                          onboardingStore.occupation.isNotEmpty
                              ? onboardingStore.occupation
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Exact Nature of Duties',
                          onboardingStore.exactNatureOfDuties.isNotEmpty
                              ? onboardingStore.exactNatureOfDuties
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Samaj Name',
                          onboardingStore.samajName.isNotEmpty
                              ? onboardingStore.samajName
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Qualification',
                          onboardingStore.qualification.isNotEmpty
                              ? onboardingStore.qualification
                              : 'Not provided',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacing3xl),

                  // Contact Information Section
                  _buildSectionHeader(
                    'Contact Information',
                    Icons.contact_phone,
                  ),
                  const SizedBox(height: AppSpacing.spacing2xl),

                  Observer(
                    builder: (_) => Column(
                      children: [
                        _buildSummaryItem(
                          'Email ID',
                          onboardingStore.emailId.isNotEmpty
                              ? onboardingStore.emailId
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Phone Number',
                          onboardingStore.phoneNumber.isNotEmpty
                              ? onboardingStore.phoneNumber
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Alternative Number',
                          onboardingStore.alternativeNumber.isNotEmpty
                              ? onboardingStore.alternativeNumber
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Landline Number',
                          onboardingStore.landlineNumber.isNotEmpty
                              ? onboardingStore.landlineNumber
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Social Media Link',
                          onboardingStore.socialMediaLink.isNotEmpty
                              ? onboardingStore.socialMediaLink
                              : 'Not provided',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacing3xl),

                  // Address Information Section
                  _buildSectionHeader('Address Information', Icons.location_on),
                  const SizedBox(height: AppSpacing.spacing2xl),

                  Observer(
                    builder: (_) => Column(
                      children: [
                        _buildSummaryItem(
                          'Flat Number',
                          onboardingStore.flatNumber.isNotEmpty
                              ? onboardingStore.flatNumber
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Building Name',
                          onboardingStore.buildingName.isNotEmpty
                              ? onboardingStore.buildingName
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Street Name',
                          onboardingStore.streetName.isNotEmpty
                              ? onboardingStore.streetName
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Landmark',
                          onboardingStore.landmark.isNotEmpty
                              ? onboardingStore.landmark
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'City',
                          onboardingStore.city.isNotEmpty
                              ? onboardingStore.city
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'District',
                          onboardingStore.district.isNotEmpty
                              ? onboardingStore.district
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'State',
                          onboardingStore.state.isNotEmpty
                              ? onboardingStore.state
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Pincode',
                          onboardingStore.pincode.isNotEmpty
                              ? onboardingStore.pincode
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Native City',
                          onboardingStore.nativeCity.isNotEmpty
                              ? onboardingStore.nativeCity
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Native State',
                          onboardingStore.nativeState.isNotEmpty
                              ? onboardingStore.nativeState
                              : 'Not provided',
                        ),
                        _buildSummaryItem(
                          'Country',
                          onboardingStore.country.isNotEmpty
                              ? onboardingStore.country
                              : 'Not provided',
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
                text: 'Submit Profile',
                onPressed: onboardingStore.onSubmitProfile,
                isLoading: onboardingStore.submitProfileStatus.isLoading,
              ),
            ),
            const SizedBox(height: AppSpacing.spacingLg),
            Center(
              child: Text(
                'Welcome to the family!',
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.familyPrimary, size: 24),
        const SizedBox(width: AppSpacing.spacingSm),
        Text(
          title,
          style: AppStyles.h3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: AppStyles.label1.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.spacingSm),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.label1.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
