// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingStore on _OnboardingStore, Store {
  Computed<bool>? _$isPersonalInfoCompleteComputed;

  @override
  bool get isPersonalInfoComplete =>
      (_$isPersonalInfoCompleteComputed ??= Computed<bool>(
        () => super.isPersonalInfoComplete,
        name: '_OnboardingStore.isPersonalInfoComplete',
      )).value;

  late final _$currentPageAtom = Atom(
    name: '_OnboardingStore.currentPage',
    context: context,
  );

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$nameAtom = Atom(name: '_OnboardingStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$ageAtom = Atom(name: '_OnboardingStore.age', context: context);

  @override
  int get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(int value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$birthDateAtom = Atom(
    name: '_OnboardingStore.birthDate',
    context: context,
  );

  @override
  DateTime? get birthDate {
    _$birthDateAtom.reportRead();
    return super.birthDate;
  }

  @override
  set birthDate(DateTime? value) {
    _$birthDateAtom.reportWrite(value, super.birthDate, () {
      super.birthDate = value;
    });
  }

  late final _$bloodGroupAtom = Atom(
    name: '_OnboardingStore.bloodGroup',
    context: context,
  );

  @override
  String get bloodGroup {
    _$bloodGroupAtom.reportRead();
    return super.bloodGroup;
  }

  @override
  set bloodGroup(String value) {
    _$bloodGroupAtom.reportWrite(value, super.bloodGroup, () {
      super.bloodGroup = value;
    });
  }

  late final _$genderAtom = Atom(
    name: '_OnboardingStore.gender',
    context: context,
  );

  @override
  Gender? get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(Gender? value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$maritalStatusAtom = Atom(
    name: '_OnboardingStore.maritalStatus',
    context: context,
  );

  @override
  String get maritalStatus {
    _$maritalStatusAtom.reportRead();
    return super.maritalStatus;
  }

  @override
  set maritalStatus(String value) {
    _$maritalStatusAtom.reportWrite(value, super.maritalStatus, () {
      super.maritalStatus = value;
    });
  }

  late final _$occupationAtom = Atom(
    name: '_OnboardingStore.occupation',
    context: context,
  );

  @override
  String get occupation {
    _$occupationAtom.reportRead();
    return super.occupation;
  }

  @override
  set occupation(String value) {
    _$occupationAtom.reportWrite(value, super.occupation, () {
      super.occupation = value;
    });
  }

  late final _$exactNatureOfDutiesAtom = Atom(
    name: '_OnboardingStore.exactNatureOfDuties',
    context: context,
  );

  @override
  String get exactNatureOfDuties {
    _$exactNatureOfDutiesAtom.reportRead();
    return super.exactNatureOfDuties;
  }

  @override
  set exactNatureOfDuties(String value) {
    _$exactNatureOfDutiesAtom.reportWrite(value, super.exactNatureOfDuties, () {
      super.exactNatureOfDuties = value;
    });
  }

  late final _$samajNameAtom = Atom(
    name: '_OnboardingStore.samajName',
    context: context,
  );

  @override
  String get samajName {
    _$samajNameAtom.reportRead();
    return super.samajName;
  }

  @override
  set samajName(String value) {
    _$samajNameAtom.reportWrite(value, super.samajName, () {
      super.samajName = value;
    });
  }

  late final _$qualificationAtom = Atom(
    name: '_OnboardingStore.qualification',
    context: context,
  );

  @override
  String get qualification {
    _$qualificationAtom.reportRead();
    return super.qualification;
  }

  @override
  set qualification(String value) {
    _$qualificationAtom.reportWrite(value, super.qualification, () {
      super.qualification = value;
    });
  }

  late final _$emailIdAtom = Atom(
    name: '_OnboardingStore.emailId',
    context: context,
  );

  @override
  String get emailId {
    _$emailIdAtom.reportRead();
    return super.emailId;
  }

  @override
  set emailId(String value) {
    _$emailIdAtom.reportWrite(value, super.emailId, () {
      super.emailId = value;
    });
  }

  late final _$phoneNumberAtom = Atom(
    name: '_OnboardingStore.phoneNumber',
    context: context,
  );

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$alternativeNumberAtom = Atom(
    name: '_OnboardingStore.alternativeNumber',
    context: context,
  );

  @override
  String get alternativeNumber {
    _$alternativeNumberAtom.reportRead();
    return super.alternativeNumber;
  }

  @override
  set alternativeNumber(String value) {
    _$alternativeNumberAtom.reportWrite(value, super.alternativeNumber, () {
      super.alternativeNumber = value;
    });
  }

  late final _$landlineNumberAtom = Atom(
    name: '_OnboardingStore.landlineNumber',
    context: context,
  );

  @override
  String get landlineNumber {
    _$landlineNumberAtom.reportRead();
    return super.landlineNumber;
  }

  @override
  set landlineNumber(String value) {
    _$landlineNumberAtom.reportWrite(value, super.landlineNumber, () {
      super.landlineNumber = value;
    });
  }

  late final _$socialMediaLinkAtom = Atom(
    name: '_OnboardingStore.socialMediaLink',
    context: context,
  );

  @override
  String get socialMediaLink {
    _$socialMediaLinkAtom.reportRead();
    return super.socialMediaLink;
  }

  @override
  set socialMediaLink(String value) {
    _$socialMediaLinkAtom.reportWrite(value, super.socialMediaLink, () {
      super.socialMediaLink = value;
    });
  }

  late final _$flatNumberAtom = Atom(
    name: '_OnboardingStore.flatNumber',
    context: context,
  );

  @override
  String get flatNumber {
    _$flatNumberAtom.reportRead();
    return super.flatNumber;
  }

  @override
  set flatNumber(String value) {
    _$flatNumberAtom.reportWrite(value, super.flatNumber, () {
      super.flatNumber = value;
    });
  }

  late final _$buildingNameAtom = Atom(
    name: '_OnboardingStore.buildingName',
    context: context,
  );

  @override
  String get buildingName {
    _$buildingNameAtom.reportRead();
    return super.buildingName;
  }

  @override
  set buildingName(String value) {
    _$buildingNameAtom.reportWrite(value, super.buildingName, () {
      super.buildingName = value;
    });
  }

  late final _$streetNameAtom = Atom(
    name: '_OnboardingStore.streetName',
    context: context,
  );

  @override
  String get streetName {
    _$streetNameAtom.reportRead();
    return super.streetName;
  }

  @override
  set streetName(String value) {
    _$streetNameAtom.reportWrite(value, super.streetName, () {
      super.streetName = value;
    });
  }

  late final _$landmarkAtom = Atom(
    name: '_OnboardingStore.landmark',
    context: context,
  );

  @override
  String get landmark {
    _$landmarkAtom.reportRead();
    return super.landmark;
  }

  @override
  set landmark(String value) {
    _$landmarkAtom.reportWrite(value, super.landmark, () {
      super.landmark = value;
    });
  }

  late final _$cityAtom = Atom(name: '_OnboardingStore.city', context: context);

  @override
  String get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  late final _$districtAtom = Atom(
    name: '_OnboardingStore.district',
    context: context,
  );

  @override
  String get district {
    _$districtAtom.reportRead();
    return super.district;
  }

  @override
  set district(String value) {
    _$districtAtom.reportWrite(value, super.district, () {
      super.district = value;
    });
  }

  late final _$stateAtom = Atom(
    name: '_OnboardingStore.state',
    context: context,
  );

  @override
  String get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(String value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$nativeCityAtom = Atom(
    name: '_OnboardingStore.nativeCity',
    context: context,
  );

  @override
  String get nativeCity {
    _$nativeCityAtom.reportRead();
    return super.nativeCity;
  }

  @override
  set nativeCity(String value) {
    _$nativeCityAtom.reportWrite(value, super.nativeCity, () {
      super.nativeCity = value;
    });
  }

  late final _$nativeStateAtom = Atom(
    name: '_OnboardingStore.nativeState',
    context: context,
  );

  @override
  String get nativeState {
    _$nativeStateAtom.reportRead();
    return super.nativeState;
  }

  @override
  set nativeState(String value) {
    _$nativeStateAtom.reportWrite(value, super.nativeState, () {
      super.nativeState = value;
    });
  }

  late final _$countryAtom = Atom(
    name: '_OnboardingStore.country',
    context: context,
  );

  @override
  String get country {
    _$countryAtom.reportRead();
    return super.country;
  }

  @override
  set country(String value) {
    _$countryAtom.reportWrite(value, super.country, () {
      super.country = value;
    });
  }

  late final _$pincodeAtom = Atom(
    name: '_OnboardingStore.pincode',
    context: context,
  );

  @override
  String get pincode {
    _$pincodeAtom.reportRead();
    return super.pincode;
  }

  @override
  set pincode(String value) {
    _$pincodeAtom.reportWrite(value, super.pincode, () {
      super.pincode = value;
    });
  }

  late final _$submitProfileStatusAtom = Atom(
    name: '_OnboardingStore.submitProfileStatus',
    context: context,
  );

  @override
  Status get submitProfileStatus {
    _$submitProfileStatusAtom.reportRead();
    return super.submitProfileStatus;
  }

  @override
  set submitProfileStatus(Status value) {
    _$submitProfileStatusAtom.reportWrite(value, super.submitProfileStatus, () {
      super.submitProfileStatus = value;
    });
  }

  late final _$_OnboardingStoreActionController = ActionController(
    name: '_OnboardingStore',
    context: context,
  );

  @override
  void onNextPage() {
    final _$actionInfo = _$_OnboardingStoreActionController.startAction(
      name: '_OnboardingStore.onNextPage',
    );
    try {
      return super.onNextPage();
    } finally {
      _$_OnboardingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPreviousPage() {
    final _$actionInfo = _$_OnboardingStoreActionController.startAction(
      name: '_OnboardingStore.onPreviousPage',
    );
    try {
      return super.onPreviousPage();
    } finally {
      _$_OnboardingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> onSubmitProfile() {
    final _$actionInfo = _$_OnboardingStoreActionController.startAction(
      name: '_OnboardingStore.onSubmitProfile',
    );
    try {
      return super.onSubmitProfile();
    } finally {
      _$_OnboardingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
name: ${name},
age: ${age},
birthDate: ${birthDate},
bloodGroup: ${bloodGroup},
gender: ${gender},
maritalStatus: ${maritalStatus},
occupation: ${occupation},
exactNatureOfDuties: ${exactNatureOfDuties},
samajName: ${samajName},
qualification: ${qualification},
emailId: ${emailId},
phoneNumber: ${phoneNumber},
alternativeNumber: ${alternativeNumber},
landlineNumber: ${landlineNumber},
socialMediaLink: ${socialMediaLink},
flatNumber: ${flatNumber},
buildingName: ${buildingName},
streetName: ${streetName},
landmark: ${landmark},
city: ${city},
district: ${district},
state: ${state},
nativeCity: ${nativeCity},
nativeState: ${nativeState},
country: ${country},
pincode: ${pincode},
submitProfileStatus: ${submitProfileStatus},
isPersonalInfoComplete: ${isPersonalInfoComplete}
    ''';
  }
}
