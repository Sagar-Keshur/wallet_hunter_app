import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/enum/state_type.dart';
import '../../../core/models/family_model/family_model.dart';
import '../../../core/stores/base_store/base_store.dart';
import '../../../core/utils/api_helper.dart';
import '../../../core/utils/shared_preferences_helper.dart';
import '../../../dependency_manager/dependency_manager.dart';
import '../../../router/route_helper.dart';

part 'onboarding_store.g.dart';

class OnboardingStore = _OnboardingStore with _$OnboardingStore;

abstract class _OnboardingStore extends BaseStore with Store {
  _OnboardingStore({
    FirestoreRepository<FamilyModel>? familyRepository,
    SharedPreferencesHelper? sharedPreferencesHelper,
  }) : _familyRepository =
           familyRepository ?? getIt<FirestoreRepository<FamilyModel>>(),
       _sharedPreferencesHelper =
           sharedPreferencesHelper ?? getIt<SharedPreferencesHelper>();

  late final FirestoreRepository<FamilyModel> _familyRepository;
  late final SharedPreferencesHelper _sharedPreferencesHelper;

  final PageController pageController = PageController();

  final int totalPages = 4;

  @observable
  int currentPage = 0;

  // Personal Information Page
  @observable
  String name = '';

  @observable
  int age = 0;

  @observable
  DateTime? birthDate;

  @observable
  String bloodGroup = '';

  @observable
  Gender? gender;

  @observable
  String maritalStatus = '';

  @observable
  String occupation = '';

  @observable
  String exactNatureOfDuties = '';

  @observable
  String samajName = '';

  @observable
  String qualification = '';

  // Contact Information Page
  @observable
  String emailId = '';

  @observable
  String phoneNumber = '';

  @observable
  String alternativeNumber = '';

  @observable
  String landlineNumber = '';

  @observable
  String socialMediaLink = '';

  // Address Page
  @observable
  String flatNumber = '';

  @observable
  String buildingName = '';

  @observable
  String streetName = '';

  @observable
  String landmark = '';

  @observable
  String city = '';

  @observable
  String district = '';

  @observable
  String state = '';

  @observable
  String nativeCity = '';

  @observable
  String nativeState = '';

  @observable
  String country = '';

  @observable
  String pincode = '';

  @observable
  Status submitProfileStatus = Status.initial;

  @computed
  bool get isPersonalInfoComplete {
    return name.isNotEmpty &&
        birthDate != null &&
        bloodGroup.isNotEmpty &&
        gender != null &&
        maritalStatus.isNotEmpty &&
        occupation.isNotEmpty &&
        exactNatureOfDuties.isNotEmpty &&
        samajName.isNotEmpty &&
        qualification.isNotEmpty;
  }

  void onBackPressed() {
    if (currentPage == 0) {
      getIt<RouteHelper>().showAuthGuardScreenAndRemoveEverything();
      return;
    }
    onPreviousPage();
  }

  @action
  void onNextPage() {
    unawaited(
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @action
  void onPreviousPage() {
    unawaited(
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @action
  Future<void> onSubmitProfile() {
    return tryCatchWrapper(
      action: () async {
        submitProfileStatus = Status.loading;
        final model = getFamilyModel;
        await _familyRepository.addDocumentWithId(
          model: model,
          id: model.memberId,
        );
        await _sharedPreferencesHelper.setBasicInfoStateTrue();
        await _sharedPreferencesHelper.setEmail(emailId);
        submitProfileStatus = Status.loaded;
        getIt<RouteHelper>().showAuthGuardScreenAndRemoveEverything();
      },
      errorAction: (error) async {
        submitProfileStatus = Status.error;
      },
    );
  }

  FamilyModel get getFamilyModel {
    final head = HeadMemberModel(
      emailId: emailId,
      age: age,
      alternativeNumber: alternativeNumber,
      birthDate: birthDate,
      bloodGroup: bloodGroup,
      buildingName: buildingName,
      city: city,
      country: country,
      district: district,
      exactNatureOfDuties: exactNatureOfDuties,
      flatNumber: flatNumber,
      gender: gender?.name,
      landlineNumber: landlineNumber,
      landmark: landmark,
      maritalStatus: maritalStatus,
      name: name,
      nativeCity: nativeCity,
      nativeState: nativeState,
      occupation: occupation,
      phoneNumber: phoneNumber,
      pincode: pincode,
      qualification: qualification,
      samajName: samajName,
      socialMediaLink: socialMediaLink,
      state: state,
      streetName: streetName,
    );

    return FamilyModel(
      memberId: _sharedPreferencesHelper.getUserId(),
      head: head,
      headPhoneNumber: phoneNumber,
      associatedTemples: head.getAssociatedTemples(),
    );
  }
}
