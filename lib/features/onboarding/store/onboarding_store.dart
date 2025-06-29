import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/stores/base_store/base_store.dart';
import '../../../dependency_manager/dependency_manager.dart';
import '../../../router/route_helper.dart';

part 'onboarding_store.g.dart';

class OnboardingStore = _OnboardingStore with _$OnboardingStore;

abstract class _OnboardingStore extends BaseStore with Store {
  _OnboardingStore();

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

  @computed
  bool get isContactInfoComplete {
    return emailId.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        alternativeNumber.isNotEmpty &&
        landlineNumber.isNotEmpty &&
        socialMediaLink.isNotEmpty;
  }

  @computed
  bool get isAddressComplete {
    return flatNumber.isNotEmpty &&
        buildingName.isNotEmpty &&
        streetName.isNotEmpty &&
        landmark.isNotEmpty &&
        city.isNotEmpty &&
        district.isNotEmpty &&
        state.isNotEmpty &&
        nativeCity.isNotEmpty &&
        nativeState.isNotEmpty &&
        country.isNotEmpty &&
        pincode.isNotEmpty;
  }

  @computed
  bool get isProfileSummaryComplete {
    return name.isNotEmpty &&
        age > 0 &&
        gender != null &&
        maritalStatus.isNotEmpty &&
        occupation.isNotEmpty &&
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
}
