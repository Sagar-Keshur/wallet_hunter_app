import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../core/utils/validation_mixin.dart';
import '../../../core/widgets/widgets.dart';
import '../store/onboarding_store.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> with ValidationMixin {
  late OnboardingStore onboardingStore;
  final _flatNumberController = TextEditingController();
  final _buildingNameController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _nativeCityController = TextEditingController();
  final _nativeStateController = TextEditingController();
  final _countryController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    onboardingStore = context.read<OnboardingStore>();
    _initializeControllers();
  }

  void _initializeControllers() {
    _flatNumberController.text = onboardingStore.flatNumber;
    _buildingNameController.text = onboardingStore.buildingName;
    _streetNameController.text = onboardingStore.streetName;
    _landmarkController.text = onboardingStore.landmark;
    _cityController.text = onboardingStore.city;
    _districtController.text = onboardingStore.district;
    _stateController.text = onboardingStore.state;
    _nativeCityController.text = onboardingStore.nativeCity;
    _nativeStateController.text = onboardingStore.nativeState;
    _countryController.text = onboardingStore.country;
    _pincodeController.text = onboardingStore.pincode;
  }

  @override
  void dispose() {
    _flatNumberController.dispose();
    _buildingNameController.dispose();
    _streetNameController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _nativeCityController.dispose();
    _nativeStateController.dispose();
    _countryController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _onFlatNumberChanged(String? value) {
    onboardingStore.flatNumber = value ?? '';
  }

  void _onBuildingNameChanged(String? value) {
    onboardingStore.buildingName = value ?? '';
  }

  void _onStreetNameChanged(String? value) {
    onboardingStore.streetName = value ?? '';
  }

  void _onLandmarkChanged(String? value) {
    onboardingStore.landmark = value ?? '';
  }

  void _onCityChanged(String? value) {
    onboardingStore.city = value ?? '';
  }

  void _onDistrictChanged(String? value) {
    onboardingStore.district = value ?? '';
  }

  void _onStateChanged(String? value) {
    onboardingStore.state = value ?? '';
  }

  void _onNativeCityChanged(String? value) {
    onboardingStore.nativeCity = value ?? '';
  }

  void _onNativeStateChanged(String? value) {
    onboardingStore.nativeState = value ?? '';
  }

  void _onCountryChanged(String? value) {
    onboardingStore.country = value ?? '';
  }

  void _onPincodeChanged(String? value) {
    onboardingStore.pincode = value ?? '';
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
                      'Address Information',
                      style: AppStyles.h2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacingSm),
                    Text(
                      'Where do you live?',
                      style: AppStyles.p1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing3xl),
                    // Current Address Section
                    Text(
                      'Current Address',
                      style: AppStyles.h3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Flat Number
                    AppTextField(
                      controller: _flatNumberController,
                      label: 'Flat Number',
                      hintText: 'Enter flat/house number',
                      leadingIcon: Icons.home_outlined,
                      onChanged: _onFlatNumberChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'flat number'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Building Name
                    AppTextField(
                      controller: _buildingNameController,
                      label: 'Building Name',
                      hintText: 'Enter building name',
                      leadingIcon: Icons.business_outlined,
                      onChanged: _onBuildingNameChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'building name'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Street Name
                    AppTextField(
                      controller: _streetNameController,
                      label: 'Street Name',
                      hintText: 'Enter street name',
                      leadingIcon: Icons.streetview_outlined,
                      onChanged: _onStreetNameChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'street name'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Landmark
                    AppTextField(
                      controller: _landmarkController,
                      label: 'Landmark',
                      hintText: 'Enter nearby landmark',
                      leadingIcon: Icons.location_on_outlined,
                      onChanged: _onLandmarkChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'landmark'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // City
                    AppTextField(
                      controller: _cityController,
                      label: 'City',
                      hintText: 'Enter city name',
                      leadingIcon: Icons.location_city_outlined,
                      onChanged: _onCityChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'city'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // District
                    AppTextField(
                      controller: _districtController,
                      label: 'District',
                      hintText: 'Enter district name',
                      leadingIcon: Icons.map_outlined,
                      onChanged: _onDistrictChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'district'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // State
                    AppTextField(
                      controller: _stateController,
                      label: 'State',
                      hintText: 'Enter state name',
                      leadingIcon: Icons.public_outlined,
                      onChanged: _onStateChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'state'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Pincode
                    AppTextField(
                      controller: _pincodeController,
                      label: 'Pincode',
                      hintText: 'Enter pincode',
                      leadingIcon: Icons.pin_drop_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: _onPincodeChanged,
                      validator: pincodeValidator,
                    ),
                    const SizedBox(height: AppSpacing.spacing3xl),
                    // Native Address Section
                    Text(
                      'Native Address',
                      style: AppStyles.h3.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Native City
                    AppTextField(
                      controller: _nativeCityController,
                      label: 'Native City',
                      hintText: 'Enter your native city',
                      leadingIcon: Icons.location_city_outlined,
                      onChanged: _onNativeCityChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'native city'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Native State
                    AppTextField(
                      controller: _nativeStateController,
                      label: 'Native State',
                      hintText: 'Enter your native state',
                      leadingIcon: Icons.public_outlined,
                      onChanged: _onNativeStateChanged,
                      validator: (value) =>
                          requiredFieldValidator(value, 'native state'),
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Country
                    AppTextField(
                      controller: _countryController,
                      label: 'Country',
                      hintText: 'Enter country name',
                      leadingIcon: Icons.flag_outlined,
                      onChanged: _onCountryChanged,
                      validator: (value) {
                        return requiredFieldValidator(value, 'country');
                      },
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
                "Your family's location matters",
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
