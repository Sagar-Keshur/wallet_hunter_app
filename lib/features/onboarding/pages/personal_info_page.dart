import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/validation_mixin.dart';
import '../../../core/widgets/widgets.dart';
import '../store/onboarding_store.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage>
    with ValidationMixin {
  late OnboardingStore onboardingStore;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _occupationController = TextEditingController();
  final _exactNatureOfDutiesController = TextEditingController();
  final _samajNameController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _maritalStatusOptions = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
    'Separated',
  ];

  final List<String> _bloodGroupOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();
    onboardingStore = context.read<OnboardingStore>();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController.text = onboardingStore.name;
    _ageController.text = onboardingStore.age > 0
        ? onboardingStore.age.toString()
        : '';
    _birthDateController.text = onboardingStore.birthDate != null
        ? _formatDate(onboardingStore.birthDate!)
        : '';
    _bloodGroupController.text = onboardingStore.bloodGroup;
    _maritalStatusController.text = onboardingStore.maritalStatus;
    _occupationController.text = onboardingStore.occupation;
    _exactNatureOfDutiesController.text = onboardingStore.exactNatureOfDuties;
    _samajNameController.text = onboardingStore.samajName;
    _qualificationController.text = onboardingStore.qualification;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _birthDateController.dispose();
    _bloodGroupController.dispose();
    _maritalStatusController.dispose();
    _occupationController.dispose();
    _exactNatureOfDutiesController.dispose();
    _samajNameController.dispose();
    _qualificationController.dispose();
    super.dispose();
  }

  void _onNameChanged(String? value) {
    onboardingStore.name = value ?? '';
  }

  void _onBirthDateChanged(DateTime? date) {
    onboardingStore.birthDate = date;
    if (date != null) {
      _birthDateController.text = _formatDate(date);
      final today = DateTime.now();
      int age = today.year - date.year;
      if (today.month < date.month ||
          (today.month == date.month && today.day < date.day)) {
        age--;
      }
      onboardingStore.age = age;
      _ageController.text = age.toString();
    }
  }

  void _onBloodGroupChanged(String? value) {
    onboardingStore.bloodGroup = value ?? '';
  }

  void _onMaritalStatusChanged(String? value) {
    onboardingStore.maritalStatus = value ?? '';
  }

  void _onOccupationChanged(String? value) {
    onboardingStore.occupation = value ?? '';
  }

  void _onExactNatureOfDutiesChanged(String? value) {
    onboardingStore.exactNatureOfDuties = value ?? '';
  }

  void _onSamajNameChanged(String? value) {
    onboardingStore.samajName = value ?? '';
  }

  void _onQualificationChanged(String? value) {
    onboardingStore.qualification = value ?? '';
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
                      'Basic Details',
                      style: AppStyles.h2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing3xl),
                    // Name Field
                    AppTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      hintText: 'Enter your full name',
                      leadingIcon: Icons.person_outline,
                      onChanged: _onNameChanged,
                      validator: nameValidator,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Birth Date
                    AppTextField(
                      controller: _birthDateController,
                      label: 'Birth Date',
                      hintText: 'Enter your birth date',
                      leadingIcon: Icons.cake_outlined,
                      onTap: _showBirthDatePicker,
                      readOnly: true,
                      validator: (value) {
                        return requiredFieldValidator(value, 'birth date');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Age Field
                    AppTextField(
                      controller: _ageController,
                      label: 'Age',
                      hintText: 'Age will be calculated from birth date',
                      leadingIcon: Icons.cake_outlined,
                      readOnly: true,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Blood Group
                    AppTextField(
                      controller: _bloodGroupController,
                      label: 'Blood Group',
                      hintText: 'Select your blood group',
                      leadingIcon: Icons.bloodtype_outlined,
                      onTap: _showBloodGroupPicker,
                      readOnly: true,
                      validator: (value) {
                        return requiredFieldValidator(value, 'blood group');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Gender Selection
                    Text(
                      'Gender',
                      style: AppStyles.label1.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacingSm),
                    Observer(
                      builder: (_) => Wrap(
                        spacing: AppSpacing.spacingSm,
                        runSpacing: AppSpacing.spacingSm,
                        children: Gender.values.map((gender) {
                          final isSelected = onboardingStore.gender == gender;
                          return GestureDetector(
                            onTap: () => onboardingStore.gender = gender,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.spacingLg,
                                vertical: AppSpacing.spacingMd,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.familyPrimary
                                    : AppColors.bgTertiary,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusNormal,
                                ),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.familyPrimary
                                      : AppColors.borderDisabled,
                                ),
                              ),
                              child: Text(
                                gender.displayName,
                                style: AppStyles.label1.copyWith(
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing3xl),
                    // Marital Status
                    AppTextField(
                      controller: _maritalStatusController,
                      label: 'Marital Status',
                      hintText: 'Select your marital status',
                      leadingIcon: Icons.favorite_outline,
                      onChanged: _onMaritalStatusChanged,
                      onTap: _showMaritalStatusPicker,
                      readOnly: true,
                      validator: (value) {
                        return requiredFieldValidator(value, 'marital status');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Occupation
                    AppTextField(
                      controller: _occupationController,
                      label: 'Occupation',
                      hintText: 'Enter your occupation',
                      leadingIcon: Icons.work_outline,
                      onChanged: _onOccupationChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'occupation'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Exact Nature of Duties
                    AppTextField(
                      controller: _exactNatureOfDutiesController,
                      label: 'Exact Nature of Duties',
                      hintText: 'Enter the exact nature of your duties',
                      leadingIcon: Icons.work_outline,
                      onChanged: _onExactNatureOfDutiesChanged,
                      validator: (value) => requiredFieldValidator(
                        value,
                        'exact nature of duties',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Samaj Name
                    AppTextField(
                      controller: _samajNameController,
                      label: 'Samaj Name',
                      hintText: 'Enter your samaj name',
                      leadingIcon: Icons.group_outlined,
                      onChanged: _onSamajNameChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'samaj name'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Qualification
                    AppTextField(
                      controller: _qualificationController,
                      label: 'Qualification',
                      hintText: 'Enter your highest qualification',
                      leadingIcon: Icons.school_outlined,
                      onChanged: _onQualificationChanged,
                      validator: (value) {
                        return requiredFieldValidator(value, 'qualification');
                      },
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
                      onboardingStore.onNextPage();
                    }
                  },
                  // isDisabled: !onboardingStore.isPersonalInfoComplete,
                ),
              ),
              const SizedBox(height: AppSpacing.spacingLg),
              Center(
                child: Text(
                  'Building your family profile',
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

  Future<void> _showMaritalStatusPicker() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusRound),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.spacing2xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select Marital Status',
                  style: AppStyles.h2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spacingLg),
            Wrap(
              spacing: AppSpacing.spacingMd,
              runSpacing: AppSpacing.spacingMd,
              children: _maritalStatusOptions.map((e) {
                return InkWell(
                  onTap: () {
                    _maritalStatusController.text = e;
                    _onMaritalStatusChanged(e);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacingLg,
                      vertical: AppSpacing.spacingMd,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bgTertiary,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusNormal,
                      ),
                      border: Border.all(color: AppColors.borderDisabled),
                    ),
                    child: Text(
                      e,
                      style: AppStyles.p1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.spacingLg),
          ],
        ),
      ),
    );
  }

  Future<void> _showBirthDatePicker() async {
    final today = DateTime.now();
    await showDatePicker(
      context: context,
      initialDate: onboardingStore.birthDate ?? DateTime(today.year - 18),
      firstDate: DateTime(today.year - 100),
      lastDate: today,
    ).then((date) {
      if (date != null) {
        _onBirthDateChanged(date);
      }
    });
  }

  Future<void> _showBloodGroupPicker() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusRound),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.spacing2xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select Blood Group',
                  style: AppStyles.h2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spacingLg),
            Wrap(
              spacing: AppSpacing.spacingMd,
              runSpacing: AppSpacing.spacingMd,
              children: _bloodGroupOptions.map((e) {
                return InkWell(
                  onTap: () {
                    _bloodGroupController.text = e;
                    _onBloodGroupChanged(e);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacingLg,
                      vertical: AppSpacing.spacingMd,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bgTertiary,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusNormal,
                      ),
                      border: Border.all(color: AppColors.borderDisabled),
                    ),
                    child: Text(
                      e,
                      style: AppStyles.p1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.spacingLg),
          ],
        ),
      ),
    );
  }
}
