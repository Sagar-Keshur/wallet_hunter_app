import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/widgets/widgets.dart';
import '../store/add_member_store.dart';

class MemberSummaryPage extends StatefulWidget {
  const MemberSummaryPage({super.key});

  @override
  State<MemberSummaryPage> createState() => _MemberSummaryPageState();
}

class _MemberSummaryPageState extends State<MemberSummaryPage> {
  late AddMemberStore addMemberStore;

  @override
  void initState() {
    super.initState();
    addMemberStore = context.read<AddMemberStore>();
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Not specified';
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
        child: Observer(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Information Section
              _buildSection('Personal Information', Icons.person_outline, [
                _buildSummaryItem(
                  'Full Name',
                  '${addMemberStore.firstName} ${addMemberStore.middleName.isNotEmpty ? '${addMemberStore.middleName} ' : ''}${addMemberStore.lastName}',
                ),
                _buildSummaryItem(
                  'Birth Date',
                  _formatDate(addMemberStore.birthDate),
                ),
                _buildSummaryItem(
                  'Age',
                  addMemberStore.age > 0
                      ? '${addMemberStore.age} years'
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Gender',
                  addMemberStore.gender?.displayName ?? 'Not specified',
                ),
                _buildSummaryItem(
                  'Marital Status',
                  addMemberStore.maritalStatus.isNotEmpty
                      ? addMemberStore.maritalStatus
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Qualification',
                  addMemberStore.qualification.isNotEmpty
                      ? addMemberStore.qualification
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Occupation',
                  addMemberStore.occupation.isNotEmpty
                      ? addMemberStore.occupation
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Exact Nature of Duties',
                  addMemberStore.exactNatureOfDuties.isNotEmpty
                      ? addMemberStore.exactNatureOfDuties
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Blood Group',
                  addMemberStore.bloodGroup.isNotEmpty
                      ? addMemberStore.bloodGroup
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Relation with Family Head',
                  addMemberStore.relationWithFamilyHead.isNotEmpty
                      ? addMemberStore.relationWithFamilyHead
                      : 'Not specified',
                ),
              ]),
              const SizedBox(height: AppSpacing.spacing2xl),

              // Contact Information Section
              _buildSection(
                'Contact Information',
                Icons.contact_phone_outlined,
                [
                  _buildSummaryItem(
                    'Phone Number',
                    addMemberStore.phoneNumber.isNotEmpty
                        ? addMemberStore.phoneNumber
                        : 'Not specified',
                  ),
                  _buildSummaryItem(
                    'Alternative Number',
                    addMemberStore.alternativeNumber.isNotEmpty
                        ? addMemberStore.alternativeNumber
                        : 'Not specified',
                  ),
                  _buildSummaryItem(
                    'Landline Number',
                    addMemberStore.landlineNumber.isNotEmpty
                        ? addMemberStore.landlineNumber
                        : 'Not specified',
                  ),
                  _buildSummaryItem(
                    'Email ID',
                    addMemberStore.emailId.isNotEmpty
                        ? addMemberStore.emailId
                        : 'Not specified',
                  ),
                  _buildSummaryItem(
                    'Social Media Link',
                    addMemberStore.socialMediaLink.isNotEmpty
                        ? addMemberStore.socialMediaLink
                        : 'Not specified',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.spacing2xl),

              // Current Address Section
              _buildSection('Current Address', Icons.location_on_outlined, [
                _buildSummaryItem(
                  'Country',
                  addMemberStore.country.isNotEmpty
                      ? addMemberStore.country
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'State',
                  addMemberStore.state.isNotEmpty
                      ? addMemberStore.state
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'District',
                  addMemberStore.district.isNotEmpty
                      ? addMemberStore.district
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'City',
                  addMemberStore.city.isNotEmpty
                      ? addMemberStore.city
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Street Name',
                  addMemberStore.streetName.isNotEmpty
                      ? addMemberStore.streetName
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Landmark',
                  addMemberStore.landmark.isNotEmpty
                      ? addMemberStore.landmark
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Building Name',
                  addMemberStore.buildingName.isNotEmpty
                      ? addMemberStore.buildingName
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Door Number',
                  addMemberStore.doorNumber.isNotEmpty
                      ? addMemberStore.doorNumber
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Flat Number',
                  addMemberStore.flatNumber.isNotEmpty
                      ? addMemberStore.flatNumber
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Pincode',
                  addMemberStore.pincode.isNotEmpty
                      ? addMemberStore.pincode
                      : 'Not specified',
                ),
              ]),
              const SizedBox(height: AppSpacing.spacing2xl),

              // Native Place Section
              _buildSection('Native Place', Icons.home_outlined, [
                _buildSummaryItem(
                  'Native City',
                  addMemberStore.nativeCity.isNotEmpty
                      ? addMemberStore.nativeCity
                      : 'Not specified',
                ),
                _buildSummaryItem(
                  'Native State',
                  addMemberStore.nativeState.isNotEmpty
                      ? addMemberStore.nativeState
                      : 'Not specified',
                ),
              ]),
              const SizedBox(height: AppSpacing.spacing2xl),

              // Photo Upload Section
              if (addMemberStore.photo != null)
                _buildSection('Photo Upload', Icons.photo_camera_outlined, [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusNormal,
                      ),
                      border: Border.all(color: AppColors.borderDisabled),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusNormal,
                      ),
                      child: Image.file(
                        addMemberStore.photo!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]),

              const SizedBox(height: AppSpacing.spacing4xl),
              Observer(
                builder: (_) => AppButton(
                  text: 'Add Member',
                  onPressed: () async {
                    // TODO: Implement API call to save family member
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Family member added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    addMemberStore.reset();
                    Navigator.pop(context);
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

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing2xl),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        border: Border.all(color: AppColors.borderDisabled),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.familyPrimary, size: 24),
              const SizedBox(width: AppSpacing.spacingMd),
              Text(
                title,
                style: AppStyles.h2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spacing2xl),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.spacingLg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppStyles.p1.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.spacingMd),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.p1.copyWith(
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
