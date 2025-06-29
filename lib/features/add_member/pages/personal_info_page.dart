import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/validation_mixin.dart';
import '../../../core/widgets/widgets.dart';
import '../store/add_member_store.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage>
    with ValidationMixin {
  late AddMemberStore addMemberStore;
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _ageController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _occupationController = TextEditingController();
  final _exactNatureOfDutiesController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _relationController = TextEditingController();
  final _maritalStatusController = TextEditingController();
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

  final List<String> _relationOptions = [
    'Father',
    'Mother',
    'Son',
    'Daughter',
    'Brother',
    'Sister',
    'Grandfather',
    'Grandmother',
    'Uncle',
    'Aunt',
    'Cousin',
    'Spouse',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    addMemberStore = context.read<AddMemberStore>();
    _initializeControllers();
  }

  void _initializeControllers() {
    _firstNameController.text = addMemberStore.firstName;
    _middleNameController.text = addMemberStore.middleName;
    _lastNameController.text = addMemberStore.lastName;
    _birthDateController.text = addMemberStore.birthDate != null
        ? _formatDate(addMemberStore.birthDate!)
        : '';
    _ageController.text = addMemberStore.age > 0
        ? addMemberStore.age.toString()
        : '';
    _qualificationController.text = addMemberStore.qualification;
    _occupationController.text = addMemberStore.occupation;
    _exactNatureOfDutiesController.text = addMemberStore.exactNatureOfDuties;
    _bloodGroupController.text = addMemberStore.bloodGroup;
    _relationController.text = addMemberStore.relationWithFamilyHead;
    _maritalStatusController.text = addMemberStore.maritalStatus;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    _qualificationController.dispose();
    _occupationController.dispose();
    _exactNatureOfDutiesController.dispose();
    _bloodGroupController.dispose();
    _relationController.dispose();
    _maritalStatusController.dispose();
    super.dispose();
  }

  void _onFirstNameChanged(String? value) {
    addMemberStore.firstName = value ?? '';
  }

  void _onMiddleNameChanged(String? value) {
    addMemberStore.middleName = value ?? '';
  }

  void _onLastNameChanged(String? value) {
    addMemberStore.lastName = value ?? '';
  }

  void _onBirthDateChanged(DateTime? date) {
    addMemberStore.birthDate = date;
    if (date != null) {
      _birthDateController.text = _formatDate(date);
      final today = DateTime.now();
      int age = today.year - date.year;
      if (today.month < date.month ||
          (today.month == date.month && today.day < date.day)) {
        age--;
      }
      addMemberStore.age = age;
      _ageController.text = age.toString();
    }
  }

  void _onMaritalStatusChanged(String? value) {
    addMemberStore.maritalStatus = value ?? '';
  }

  void _onQualificationChanged(String? value) {
    addMemberStore.qualification = value ?? '';
  }

  void _onOccupationChanged(String? value) {
    addMemberStore.occupation = value ?? '';
  }

  void _onExactNatureOfDutiesChanged(String? value) {
    addMemberStore.exactNatureOfDuties = value ?? '';
  }

  void _onBloodGroupChanged(String? value) {
    addMemberStore.bloodGroup = value ?? '';
  }

  void _onRelationChanged(String? value) {
    addMemberStore.relationWithFamilyHead = value ?? '';
  }

  Future<void> _showBirthDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          addMemberStore.birthDate ??
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime.now().subtract(
        const Duration(days: 36500),
      ), // 100 years ago
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _onBirthDateChanged(picked);
    }
  }

  Future<void> _showPhotoOptions() async {
    final permissionStatus = Platform.isIOS
        ? await Permission.photos.request()
        : await Permission.mediaLibrary.request();
    if (permissionStatus.isDenied) {
      if (context.mounted) {
        unawaited(
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Permission Required'),
              content: const Text(
                'Photo library access is required to select photos. Please enable it in settings.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const TextButton(
                  onPressed: openAppSettings,
                  child: Text('Open Settings'),
                ),
              ],
            ),
          ),
        );
      }
      return;
    }

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
                  'Select Photo Source',
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
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      final result = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );
                      if (result != null) {
                        addMemberStore.photo = File(result.path);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.spacingLg),
                      decoration: BoxDecoration(
                        color: AppColors.bgTertiary,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusNormal,
                        ),
                        border: Border.all(color: AppColors.borderDisabled),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: AppColors.familyPrimary,
                            size: 32,
                          ),
                          const SizedBox(height: AppSpacing.spacingSm),
                          Text(
                            'Camera',
                            style: AppStyles.p1.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      final result = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (result != null) {
                        addMemberStore.photo = File(result.path);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.spacingLg),
                      decoration: BoxDecoration(
                        color: AppColors.bgTertiary,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusNormal,
                        ),
                        border: Border.all(color: AppColors.borderDisabled),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.photo_library,
                            color: AppColors.familyPrimary,
                            size: 32,
                          ),
                          const SizedBox(height: AppSpacing.spacingSm),
                          Text(
                            'Gallery',
                            style: AppStyles.p1.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spacingLg),
          ],
        ),
      ),
    );
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
                      'Personal Information',
                      style: AppStyles.h2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing3xl),

                    // First Name
                    AppTextField(
                      controller: _firstNameController,
                      label: 'First Name',
                      hintText: 'Enter first name',
                      leadingIcon: Icons.person_outline,
                      onChanged: _onFirstNameChanged,
                      validator: nameValidator,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Middle Name
                    AppTextField(
                      controller: _middleNameController,
                      label: 'Middle Name',
                      hintText: 'Enter middle name (optional)',
                      leadingIcon: Icons.person_outline,
                      onChanged: _onMiddleNameChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Last Name
                    AppTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      hintText: 'Enter last name',
                      leadingIcon: Icons.person_outline,
                      onChanged: _onLastNameChanged,
                      validator: nameValidator,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Birth Date
                    AppTextField(
                      controller: _birthDateController,
                      label: 'Birth Date',
                      hintText: 'Select birth date',
                      leadingIcon: Icons.cake_outlined,
                      onTap: _showBirthDatePicker,
                      readOnly: true,
                      validator: (value) {
                        return requiredFieldValidator(value, 'birth date');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Age (Read-only)
                    AppTextField(
                      controller: _ageController,
                      label: 'Age',
                      hintText: 'Age will be calculated from birth date',
                      leadingIcon: Icons.cake_outlined,
                      readOnly: true,
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
                          final isSelected = addMemberStore.gender == gender;
                          return GestureDetector(
                            onTap: () => addMemberStore.gender = gender,
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

                    // Qualification
                    AppTextField(
                      controller: _qualificationController,
                      label: 'Qualification',
                      hintText: 'Enter qualification',
                      leadingIcon: Icons.school_outlined,
                      onChanged: _onQualificationChanged,
                      validator: (value) {
                        return requiredFieldValidator(value, 'qualification');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Occupation
                    AppTextField(
                      controller: _occupationController,
                      label: 'Occupation',
                      hintText: 'Enter occupation',
                      leadingIcon: Icons.work_outline,
                      onChanged: _onOccupationChanged,
                      validator: (value) {
                        return requiredFieldValidator(value, 'occupation');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Exact Nature of Duties
                    AppTextField(
                      controller: _exactNatureOfDutiesController,
                      label: 'Exact Nature of Duties',
                      hintText: 'Enter exact nature of duties',
                      leadingIcon: Icons.description_outlined,
                      onChanged: _onExactNatureOfDutiesChanged,
                      validator: (value) {
                        return requiredFieldValidator(
                          value,
                          'exact nature of duties',
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Blood Group
                    AppTextField(
                      controller: _bloodGroupController,
                      label: 'Blood Group',
                      hintText: 'Select your blood group',
                      leadingIcon: Icons.bloodtype_outlined,
                      onChanged: _onBloodGroupChanged,
                      onTap: _showBloodGroupPicker,
                      readOnly: true,
                      validator: (value) {
                        return requiredFieldValidator(value, 'blood group');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Relation with Family Head
                    AppTextField(
                      controller: _relationController,
                      label: 'Relation with Family Head',
                      hintText: 'Select relation with family head',
                      leadingIcon: Icons.family_restroom_outlined,
                      onChanged: _onRelationChanged,
                      onTap: _showRelationPicker,
                      readOnly: true,
                      validator: (value) {
                        return requiredFieldValidator(
                          value,
                          'relation with family head',
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Photo Upload
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.spacingLg),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderDisabled),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusRound,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.photo_camera_outlined,
                                color: AppColors.textSecondary,
                                size: 20,
                              ),
                              const SizedBox(width: AppSpacing.spacingMd),
                              Text(
                                'Photo Upload',
                                style: AppStyles.p1.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.spacingMd),
                          Observer(
                            builder: (_) => GestureDetector(
                              onTap: _showPhotoOptions,
                              child: Container(
                                width: double.infinity,
                                height: addMemberStore.photo != null
                                    ? null
                                    : 120,
                                decoration: BoxDecoration(
                                  color: AppColors.bgPrimary,
                                  border: Border.all(
                                    color: AppColors.borderDisabled,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusMedium,
                                  ),
                                ),
                                child: addMemberStore.photo != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          AppSpacing.radiusMedium,
                                        ),
                                        child: Image.file(
                                          addMemberStore.photo!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add_a_photo,
                                            color: AppColors.textSecondary,
                                            size: 32,
                                          ),
                                          const SizedBox(
                                            height: AppSpacing.spacingSm,
                                          ),
                                          Text(
                                            'Tap to upload photo',
                                            style: AppStyles.p2.copyWith(
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
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
                  text: 'Continue',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      addMemberStore.onNextPage();
                    }
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

  Future<void> _showRelationPicker() async {
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
                Expanded(
                  child: Text(
                    'Select Relation with Family Head',
                    style: AppStyles.h2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.spacingLg),
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
              children: _relationOptions.map((e) {
                return InkWell(
                  onTap: () {
                    _relationController.text = e;
                    _onRelationChanged(e);
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
