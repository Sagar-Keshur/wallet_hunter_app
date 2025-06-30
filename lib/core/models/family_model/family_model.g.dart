// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyModel _$FamilyModelFromJson(Map<String, dynamic> json) => FamilyModel(
  head: HeadMemberModel.fromJson(json['head'] as Map<String, dynamic>),
  headPhoneNumber: json['headPhoneNumber'] as String,
  memberId: json['memberId'] as String,
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  familyMemberPhoneNumbers:
      (json['familyMemberPhoneNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  associatedTemples:
      (json['associatedTemples'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$FamilyModelToJson(FamilyModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'head': instance.head.toJson(),
      'headPhoneNumber': instance.headPhoneNumber,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'familyMemberPhoneNumbers': instance.familyMemberPhoneNumbers,
      'associatedTemples': instance.associatedTemples,
    };

HeadMemberModel _$HeadMemberModelFromJson(Map<String, dynamic> json) =>
    HeadMemberModel(
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      bloodGroup: json['bloodGroup'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      occupation: json['occupation'] as String?,
      exactNatureOfDuties: json['exactNatureOfDuties'] as String?,
      samajName: json['samajName'] as String?,
      qualification: json['qualification'] as String?,
      emailId: json['emailId'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      alternativeNumber: json['alternativeNumber'] as String?,
      landlineNumber: json['landlineNumber'] as String?,
      socialMediaLink: json['socialMediaLink'] as String?,
      flatNumber: json['flatNumber'] as String?,
      buildingName: json['buildingName'] as String?,
      streetName: json['streetName'] as String?,
      landmark: json['landmark'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      state: json['state'] as String?,
      nativeCity: json['nativeCity'] as String?,
      nativeState: json['nativeState'] as String?,
      country: json['country'] as String?,
      pincode: json['pincode'] as String?,
    );

Map<String, dynamic> _$HeadMemberModelToJson(
  HeadMemberModel instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.age case final value?) 'age': value,
  if (instance.birthDate?.toIso8601String() case final value?)
    'birthDate': value,
  if (instance.bloodGroup case final value?) 'bloodGroup': value,
  if (instance.gender case final value?) 'gender': value,
  if (instance.maritalStatus case final value?) 'maritalStatus': value,
  if (instance.occupation case final value?) 'occupation': value,
  if (instance.exactNatureOfDuties case final value?)
    'exactNatureOfDuties': value,
  if (instance.samajName case final value?) 'samajName': value,
  if (instance.qualification case final value?) 'qualification': value,
  if (instance.emailId case final value?) 'emailId': value,
  if (instance.phoneNumber case final value?) 'phoneNumber': value,
  if (instance.alternativeNumber case final value?) 'alternativeNumber': value,
  if (instance.landlineNumber case final value?) 'landlineNumber': value,
  if (instance.socialMediaLink case final value?) 'socialMediaLink': value,
  if (instance.flatNumber case final value?) 'flatNumber': value,
  if (instance.buildingName case final value?) 'buildingName': value,
  if (instance.streetName case final value?) 'streetName': value,
  if (instance.landmark case final value?) 'landmark': value,
  if (instance.city case final value?) 'city': value,
  if (instance.district case final value?) 'district': value,
  if (instance.state case final value?) 'state': value,
  if (instance.nativeCity case final value?) 'nativeCity': value,
  if (instance.nativeState case final value?) 'nativeState': value,
  if (instance.country case final value?) 'country': value,
  if (instance.pincode case final value?) 'pincode': value,
};

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
  id: json['id'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  middleName: json['middleName'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  age: (json['age'] as num?)?.toInt() ?? 0,
  gender: json['gender'] as String?,
  maritalStatus: json['maritalStatus'] as String?,
  qualification: json['qualification'] as String?,
  occupation: json['occupation'] as String?,
  exactNatureOfDuties: json['exactNatureOfDuties'] as String?,
  bloodGroup: json['bloodGroup'] as String?,
  photo: json['photo'] as String?,
  relationWithFamilyHead: json['relationWithFamilyHead'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  alternativeNumber: json['alternativeNumber'] as String?,
  landlineNumber: json['landlineNumber'] as String?,
  emailId: json['emailId'] as String?,
  socialMediaLink: json['socialMediaLink'] as String?,
  country: json['country'] as String?,
  state: json['state'] as String?,
  district: json['district'] as String?,
  city: json['city'] as String?,
  streetName: json['streetName'] as String?,
  landmark: json['landmark'] as String?,
  buildingName: json['buildingName'] as String?,
  doorNumber: json['doorNumber'] as String?,
  flatNumber: json['flatNumber'] as String?,
  pincode: json['pincode'] as String?,
  nativeCity: json['nativeCity'] as String?,
  nativeState: json['nativeState'] as String?,
);

Map<String, dynamic> _$MemberModelToJson(
  MemberModel instance,
) => <String, dynamic>{
  'id': instance.id,
  if (instance.firstName case final value?) 'firstName': value,
  if (instance.middleName case final value?) 'middleName': value,
  if (instance.lastName case final value?) 'lastName': value,
  if (instance.birthDate?.toIso8601String() case final value?)
    'birthDate': value,
  'age': instance.age,
  if (instance.gender case final value?) 'gender': value,
  if (instance.maritalStatus case final value?) 'maritalStatus': value,
  if (instance.qualification case final value?) 'qualification': value,
  if (instance.occupation case final value?) 'occupation': value,
  if (instance.exactNatureOfDuties case final value?)
    'exactNatureOfDuties': value,
  if (instance.bloodGroup case final value?) 'bloodGroup': value,
  if (instance.photo case final value?) 'photo': value,
  if (instance.relationWithFamilyHead case final value?)
    'relationWithFamilyHead': value,
  if (instance.phoneNumber case final value?) 'phoneNumber': value,
  if (instance.alternativeNumber case final value?) 'alternativeNumber': value,
  if (instance.landlineNumber case final value?) 'landlineNumber': value,
  if (instance.emailId case final value?) 'emailId': value,
  if (instance.socialMediaLink case final value?) 'socialMediaLink': value,
  if (instance.country case final value?) 'country': value,
  if (instance.state case final value?) 'state': value,
  if (instance.district case final value?) 'district': value,
  if (instance.city case final value?) 'city': value,
  if (instance.streetName case final value?) 'streetName': value,
  if (instance.landmark case final value?) 'landmark': value,
  if (instance.buildingName case final value?) 'buildingName': value,
  if (instance.doorNumber case final value?) 'doorNumber': value,
  if (instance.flatNumber case final value?) 'flatNumber': value,
  if (instance.pincode case final value?) 'pincode': value,
  if (instance.nativeCity case final value?) 'nativeCity': value,
  if (instance.nativeState case final value?) 'nativeState': value,
};
