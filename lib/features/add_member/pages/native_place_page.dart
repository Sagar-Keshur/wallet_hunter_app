import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/style_guide/style_guide.dart';
import '../../../core/utils/validation_mixin.dart';
import '../../../core/widgets/widgets.dart';
import '../store/add_member_store.dart';

class NativePlacePage extends StatefulWidget {
  const NativePlacePage({super.key});

  @override
  State<NativePlacePage> createState() => _NativePlacePageState();
}

class _NativePlacePageState extends State<NativePlacePage>
    with ValidationMixin {
  late AddMemberStore addMemberStore;
  final _nativeCityController = TextEditingController();
  final _nativeStateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addMemberStore = context.read<AddMemberStore>();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nativeCityController.text = addMemberStore.nativeCity;
    _nativeStateController.text = addMemberStore.nativeState;
  }

  @override
  void dispose() {
    _nativeCityController.dispose();
    _nativeStateController.dispose();
    super.dispose();
  }

  void _onNativeCityChanged(String? value) {
    addMemberStore.nativeCity = value ?? '';
  }

  void _onNativeStateChanged(String? value) {
    addMemberStore.nativeState = value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMargin),
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
                    'Native Place',
                    style: AppStyles.h2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacing3xl),

                  // Native City
                  AppTextField(
                    controller: _nativeCityController,
                    label: 'Native City',
                    hintText: 'Enter native city',
                    leadingIcon: Icons.location_city_outlined,
                    onChanged: _onNativeCityChanged,
                    validator: (value) {
                      return requiredFieldValidator(value, 'native city');
                    },
                  ),
                  const SizedBox(height: AppSpacing.spacing2xl),

                  // Native State
                  AppTextField(
                    controller: _nativeStateController,
                    label: 'Native State',
                    hintText: 'Enter native state',
                    leadingIcon: Icons.location_on_outlined,
                    onChanged: _onNativeStateChanged,
                    validator: (value) {
                      return requiredFieldValidator(value, 'native state');
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
    );
  }
}
