import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/validation_mixin.dart';
import '../../../core/widgets/widgets.dart';
import '../store/add_member_store.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> with ValidationMixin {
  late AddMemberStore addMemberStore;
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _buildingNameController = TextEditingController();
  final _doorNumberController = TextEditingController();
  final _flatNumberController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addMemberStore = context.read<AddMemberStore>();
    _initializeControllers();
  }

  void _initializeControllers() {
    _countryController.text = addMemberStore.country;
    _stateController.text = addMemberStore.state;
    _districtController.text = addMemberStore.district;
    _cityController.text = addMemberStore.city;
    _streetNameController.text = addMemberStore.streetName;
    _landmarkController.text = addMemberStore.landmark;
    _buildingNameController.text = addMemberStore.buildingName;
    _doorNumberController.text = addMemberStore.doorNumber;
    _flatNumberController.text = addMemberStore.flatNumber;
    _pincodeController.text = addMemberStore.pincode;
  }

  @override
  void dispose() {
    _countryController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _streetNameController.dispose();
    _landmarkController.dispose();
    _buildingNameController.dispose();
    _doorNumberController.dispose();
    _flatNumberController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _onCountryChanged(String? value) {
    addMemberStore.country = value ?? '';
  }

  void _onStateChanged(String? value) {
    addMemberStore.state = value ?? '';
  }

  void _onDistrictChanged(String? value) {
    addMemberStore.district = value ?? '';
  }

  void _onCityChanged(String? value) {
    addMemberStore.city = value ?? '';
  }

  void _onStreetNameChanged(String? value) {
    addMemberStore.streetName = value ?? '';
  }

  void _onLandmarkChanged(String? value) {
    addMemberStore.landmark = value ?? '';
  }

  void _onBuildingNameChanged(String? value) {
    addMemberStore.buildingName = value ?? '';
  }

  void _onDoorNumberChanged(String? value) {
    addMemberStore.doorNumber = value ?? '';
  }

  void _onFlatNumberChanged(String? value) {
    addMemberStore.flatNumber = value ?? '';
  }

  void _onPincodeChanged(String? value) {
    addMemberStore.pincode = value ?? '';
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
                      'Current Address',
                      style: AppStyles.h2.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacing3xl),

                    // Flat Number
                    AppTextField(
                      controller: _flatNumberController,
                      label: 'Flat Number',
                      hintText: 'Enter flat number (optional)',
                      leadingIcon: Icons.apartment_outlined,
                      onChanged: _onFlatNumberChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Door Number
                    AppTextField(
                      controller: _doorNumberController,
                      label: 'Door Number',
                      hintText: 'Enter door number',
                      leadingIcon: Icons.home_outlined,
                      onChanged: _onDoorNumberChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Building Name
                    AppTextField(
                      controller: _buildingNameController,
                      label: 'Building Name',
                      hintText: 'Enter building name',
                      leadingIcon: Icons.business_outlined,
                      onChanged: _onBuildingNameChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Landmark
                    AppTextField(
                      controller: _landmarkController,
                      label: 'Landmark',
                      hintText: 'Enter landmark (optional)',
                      leadingIcon: Icons.place_outlined,
                      onChanged: _onLandmarkChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Street Name
                    AppTextField(
                      controller: _streetNameController,
                      label: 'Street Name',
                      hintText: 'Enter street name',
                      leadingIcon: Icons.streetview_outlined,
                      onChanged: _onStreetNameChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // City
                    AppTextField(
                      controller: _cityController,
                      label: 'City',
                      hintText: 'Enter city',
                      leadingIcon: Icons.location_city_outlined,
                      onChanged: _onCityChanged,
                      validator: (value) {
                        return requiredFieldValidator(value, 'city');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // Pincode
                    AppTextField(
                      controller: _pincodeController,
                      label: 'Pincode',
                      hintText: 'Enter pincode',
                      leadingIcon: Icons.pin_drop_outlined,
                      onChanged: _onPincodeChanged,
                      validator: pincodeValidator,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
                    // District
                    AppTextField(
                      controller: _districtController,
                      label: 'District',
                      hintText: 'Enter district',
                      leadingIcon: Icons.location_on_outlined,
                      onChanged: _onDistrictChanged,
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // State
                    AppTextField(
                      controller: _stateController,
                      label: 'State',
                      hintText: 'Enter state',
                      leadingIcon: Icons.location_on_outlined,
                      onChanged: _onStateChanged,
                      validator: (value) {
                        return requiredFieldValidator(value, 'state');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),

                    // Country
                    AppTextField(
                      controller: _countryController,
                      label: 'Country',
                      hintText: 'Enter country',
                      leadingIcon: Icons.public_outlined,
                      onChanged: _onCountryChanged,
                      validator: (value) {
                        return requiredFieldValidator(value, 'country');
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacing2xl),
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
}
