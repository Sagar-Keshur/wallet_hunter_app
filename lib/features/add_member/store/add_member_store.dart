import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/stores/base_store/base_store.dart';
import '../../../dependency_manager/dependency_manager.dart';
import '../../../router/route_helper.dart';

part 'add_member_store.g.dart';

class AddMemberStore = _AddMemberStore with _$AddMemberStore;

abstract class _AddMemberStore extends BaseStore with Store {
  _AddMemberStore();

  final PageController pageController = PageController();

  final int totalPages = 5;

  @observable
  int currentPage = 0;

  // Personal Information
  @observable
  String firstName = '';

  @observable
  String middleName = '';

  @observable
  String lastName = '';

  @observable
  DateTime? birthDate;

  @observable
  int age = 0;

  @observable
  Gender? gender;

  @observable
  String maritalStatus = '';

  @observable
  String qualification = '';

  @observable
  String occupation = '';

  @observable
  String exactNatureOfDuties = '';

  @observable
  String bloodGroup = '';

  @observable
  File? photo;

  // Relation with Family Head
  @observable
  String relationWithFamilyHead = '';

  // Contact Information
  @observable
  String phoneNumber = '';

  @observable
  String alternativeNumber = '';

  @observable
  String landlineNumber = '';

  @observable
  String emailId = '';

  @observable
  String socialMediaLink = '';

  // Current Address
  @observable
  String country = '';

  @observable
  String state = '';

  @observable
  String district = '';

  @observable
  String city = '';

  @observable
  String streetName = '';

  @observable
  String landmark = '';

  @observable
  String buildingName = '';

  @observable
  String doorNumber = '';

  @observable
  String flatNumber = '';

  @observable
  String pincode = '';

  // Native Place
  @observable
  String nativeCity = '';

  @observable
  String nativeState = '';

  @computed
  bool get isPersonalInfoComplete {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        birthDate != null &&
        gender != null &&
        maritalStatus.isNotEmpty &&
        qualification.isNotEmpty &&
        occupation.isNotEmpty &&
        exactNatureOfDuties.isNotEmpty &&
        bloodGroup.isNotEmpty;
  }

  @computed
  bool get isContactInfoComplete {
    return phoneNumber.isNotEmpty && emailId.isNotEmpty;
  }

  @computed
  bool get isAddressComplete {
    return country.isNotEmpty &&
        state.isNotEmpty &&
        city.isNotEmpty &&
        pincode.isNotEmpty;
  }

  @computed
  bool get isNativePlaceComplete {
    return nativeCity.isNotEmpty && nativeState.isNotEmpty;
  }

  @computed
  bool get isFormComplete {
    return isPersonalInfoComplete &&
        isContactInfoComplete &&
        isAddressComplete &&
        isNativePlaceComplete;
  }

  void onBackPressed() {
    if (currentPage == 0) {
      getIt<RouteHelper>().pop();
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
  void reset() {
    firstName = '';
    middleName = '';
    lastName = '';
    birthDate = null;
    age = 0;
    gender = null;
    maritalStatus = '';
    qualification = '';
    occupation = '';
    exactNatureOfDuties = '';
    bloodGroup = '';
    photo = null;
    relationWithFamilyHead = '';
    phoneNumber = '';
    alternativeNumber = '';
    landlineNumber = '';
    emailId = '';
    socialMediaLink = '';
    country = '';
    state = '';
    district = '';
    city = '';
    streetName = '';
    landmark = '';
    buildingName = '';
    doorNumber = '';
    flatNumber = '';
    pincode = '';
    nativeCity = '';
    nativeState = '';
  }
}
