import 'package:mobx/mobx.dart';

part 'family_member_store.g.dart';

@observable
class FamilyMemberStore = _FamilyMemberStoreBase with _$FamilyMemberStore;

abstract class _FamilyMemberStoreBase with Store {
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
  String gender = '';

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
  String photoPath = '';

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

  // Actions
  @action
  void setFirstName(String value) => firstName = value;

  @action
  void setMiddleName(String value) => middleName = value;

  @action
  void setLastName(String value) => lastName = value;

  @action
  void setBirthDate(DateTime? value) {
    birthDate = value;
    if (value != null) {
      final now = DateTime.now();
      age = now.year - value.year;
      if (now.month < value.month ||
          (now.month == value.month && now.day < value.day)) {
        age--;
      }
    } else {
      age = 0;
    }
  }

  @action
  void setGender(String value) => gender = value;

  @action
  void setMaritalStatus(String value) => maritalStatus = value;

  @action
  void setQualification(String value) => qualification = value;

  @action
  void setOccupation(String value) => occupation = value;

  @action
  void setExactNatureOfDuties(String value) => exactNatureOfDuties = value;

  @action
  void setBloodGroup(String value) => bloodGroup = value;

  @action
  void setPhotoPath(String value) => photoPath = value;

  @action
  void setRelationWithFamilyHead(String value) =>
      relationWithFamilyHead = value;

  @action
  void setPhoneNumber(String value) => phoneNumber = value;

  @action
  void setAlternativeNumber(String value) => alternativeNumber = value;

  @action
  void setLandlineNumber(String value) => landlineNumber = value;

  @action
  void setEmailId(String value) => emailId = value;

  @action
  void setSocialMediaLink(String value) => socialMediaLink = value;

  @action
  void setCountry(String value) => country = value;

  @action
  void setState(String value) => state = value;

  @action
  void setDistrict(String value) => district = value;

  @action
  void setCity(String value) => city = value;

  @action
  void setStreetName(String value) => streetName = value;

  @action
  void setLandmark(String value) => landmark = value;

  @action
  void setBuildingName(String value) => buildingName = value;

  @action
  void setDoorNumber(String value) => doorNumber = value;

  @action
  void setFlatNumber(String value) => flatNumber = value;

  @action
  void setPincode(String value) => pincode = value;

  @action
  void setNativeCity(String value) => nativeCity = value;

  @action
  void setNativeState(String value) => nativeState = value;

  @action
  void reset() {
    firstName = '';
    middleName = '';
    lastName = '';
    birthDate = null;
    age = 0;
    gender = '';
    maritalStatus = '';
    qualification = '';
    occupation = '';
    exactNatureOfDuties = '';
    bloodGroup = '';
    photoPath = '';
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

  // Validation methods
  bool get isPersonalInfoValid {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        birthDate != null &&
        gender.isNotEmpty &&
        maritalStatus.isNotEmpty;
  }

  bool get isContactInfoValid {
    return phoneNumber.isNotEmpty && emailId.isNotEmpty;
  }

  bool get isAddressValid {
    return country.isNotEmpty &&
        state.isNotEmpty &&
        city.isNotEmpty &&
        pincode.isNotEmpty;
  }

  bool get isNativePlaceValid {
    return nativeCity.isNotEmpty && nativeState.isNotEmpty;
  }

  bool get isFormComplete {
    return isPersonalInfoValid &&
        isContactInfoValid &&
        isAddressValid &&
        isNativePlaceValid;
  }
}
