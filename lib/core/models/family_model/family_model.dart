import 'package:json_annotation/json_annotation.dart';

import '../base_model/base_model.dart';

part 'family_model.g.dart';

@JsonSerializable()
class FamilyModel extends BaseModel {
  const FamilyModel({
    required this.head,
    required this.headPhoneNumber,
    required this.memberId,
    this.members = const [],
    this.familyMemberPhoneNumbers = const [],
    this.associatedTemples = const [],
  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    return _$FamilyModelFromJson(json);
  }

  final String memberId;
  final HeadMemberModel head;
  final String headPhoneNumber;
  final List<MemberModel> members;
  final List<String> familyMemberPhoneNumbers;
  final List<String> associatedTemples;

  Map<String, dynamic> toJson() => _$FamilyModelToJson(this);

  @override
  List<Object?> get props {
    return [memberId, head, headPhoneNumber, members, associatedTemples];
  }

  FamilyModel copyWith({
    String? memberId,
    HeadMemberModel? head,
    String? headPhoneNumber,
    List<MemberModel>? members,
    List<String>? familyMemberPhoneNumbers,
    List<String>? associatedTemples,
  }) {
    return FamilyModel(
      memberId: memberId ?? this.memberId,
      head: head ?? this.head,
      headPhoneNumber: headPhoneNumber ?? this.headPhoneNumber,
      members: members ?? this.members,
      familyMemberPhoneNumbers:
          familyMemberPhoneNumbers ?? this.familyMemberPhoneNumbers,
      associatedTemples: associatedTemples ?? this.associatedTemples,
    );
  }
}

@JsonSerializable()
class HeadMemberModel extends BaseModel {
  const HeadMemberModel({
    this.name,
    this.age,
    this.birthDate,
    this.bloodGroup,
    this.gender,
    this.maritalStatus,
    this.occupation,
    this.exactNatureOfDuties,
    this.samajName,
    this.qualification,
    this.emailId,
    this.phoneNumber,
    this.alternativeNumber,
    this.landlineNumber,
    this.socialMediaLink,
    this.flatNumber,
    this.buildingName,
    this.streetName,
    this.landmark,
    this.city,
    this.district,
    this.state,
    this.nativeCity,
    this.nativeState,
    this.country,
    this.pincode,
  });
  factory HeadMemberModel.fromJson(Map<String, dynamic> json) =>
      _$HeadMemberModelFromJson(json);

  final String? name;
  final int? age;
  final DateTime? birthDate;
  final String? bloodGroup;
  final String? gender;
  final String? maritalStatus;
  final String? occupation;
  final String? exactNatureOfDuties;
  final String? samajName;
  final String? qualification;
  final String? emailId;
  final String? phoneNumber;
  final String? alternativeNumber;
  final String? landlineNumber;
  final String? socialMediaLink;
  final String? flatNumber;
  final String? buildingName;
  final String? streetName;
  final String? landmark;
  final String? city;
  final String? district;
  final String? state;
  final String? nativeCity;
  final String? nativeState;
  final String? country;
  final String? pincode;

  Map<String, dynamic> toJson() => _$HeadMemberModelToJson(this);

  @override
  List<Object?> get props => [
    name,
    age,
    birthDate,
    bloodGroup,
    gender,
    maritalStatus,
    occupation,
    exactNatureOfDuties,
    samajName,
    qualification,
    emailId,
    phoneNumber,
    alternativeNumber,
    landlineNumber,
    socialMediaLink,
    flatNumber,
    buildingName,
    streetName,
    landmark,
    city,
    district,
    state,
    nativeCity,
    nativeState,
    country,
    pincode,
  ];

  List<String> getAssociatedTemples() {
    if (samajName == null || samajName!.isEmpty) {
      return [];
    }

    switch (samajName!.toLowerCase()) {
      case 'brahmin':
        return [
          'Shri Ram Mandir',
          'Shri Krishna Mandir',
          'Shri Ganesh Mandir',
          'Shri Hanuman Mandir',
          'Shri Durga Mandir',
        ];
      case 'kshatriya':
        return [
          'Shri Ram Mandir',
          'Shri Krishna Mandir',
          'Shri Hanuman Mandir',
          'Shri Durga Mandir',
          'Shri Kali Mandir',
        ];
      case 'vaishya':
        return [
          'Shri Lakshmi Mandir',
          'Shri Ganesh Mandir',
          'Shri Krishna Mandir',
          'Shri Hanuman Mandir',
          'Shri Saraswati Mandir',
        ];
      case 'shudra':
        return [
          'Shri Hanuman Mandir',
          'Shri Ganesh Mandir',
          'Shri Durga Mandir',
          'Shri Kali Mandir',
          'Shri Ram Mandir',
        ];
      case 'other':
        return [
          'Shri Ganesh Mandir',
          'Shri Hanuman Mandir',
          'Shri Ram Mandir',
          'Shri Krishna Mandir',
          'Shri Durga Mandir',
        ];
      default:
        return [
          'Shri Ganesh Mandir',
          'Shri Hanuman Mandir',
          'Shri Ram Mandir',
          'Shri Krishna Mandir',
          'Shri Durga Mandir',
        ];
    }
  }
}

@JsonSerializable()
class MemberModel extends BaseModel {
  const MemberModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.birthDate,
    this.age = 0,
    this.gender,
    this.maritalStatus,
    this.qualification,
    this.occupation,
    this.exactNatureOfDuties,
    this.bloodGroup,
    this.photo,
    this.relationWithFamilyHead,
    this.phoneNumber,
    this.alternativeNumber,
    this.landlineNumber,
    this.emailId,
    this.socialMediaLink,
    this.country,
    this.state,
    this.district,
    this.city,
    this.streetName,
    this.landmark,
    this.buildingName,
    this.doorNumber,
    this.flatNumber,
    this.pincode,
    this.nativeCity,
    this.nativeState,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return _$MemberModelFromJson(json);
  }

  final String id;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final DateTime? birthDate;
  final int age;
  final String? gender;
  final String? maritalStatus;
  final String? qualification;
  final String? occupation;
  final String? exactNatureOfDuties;
  final String? bloodGroup;
  final String? photo;
  final String? relationWithFamilyHead;
  final String? phoneNumber;
  final String? alternativeNumber;
  final String? landlineNumber;
  final String? emailId;
  final String? socialMediaLink;
  final String? country;
  final String? state;
  final String? district;
  final String? city;
  final String? streetName;
  final String? landmark;
  final String? buildingName;
  final String? doorNumber;
  final String? flatNumber;
  final String? pincode;
  final String? nativeCity;
  final String? nativeState;

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);

  @override
  List<Object?> get props => [
    firstName,
    middleName,
    lastName,
    birthDate,
    age,
    gender,
    maritalStatus,
    qualification,
    occupation,
    exactNatureOfDuties,
    bloodGroup,
    photo,
    relationWithFamilyHead,
    phoneNumber,
    alternativeNumber,
    landlineNumber,
    emailId,
    socialMediaLink,
    country,
    state,
    district,
    city,
    streetName,
    landmark,
    buildingName,
    doorNumber,
    flatNumber,
    pincode,
    nativeCity,
    nativeState,
  ];
}
