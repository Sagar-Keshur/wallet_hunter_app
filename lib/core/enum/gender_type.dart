import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue('female')
  female,
  @JsonValue('male')
  male,
  @JsonValue('genderQueer')
  genderQueer,
  @JsonValue('nonBinary')
  nonBinary,
  @JsonValue('preferNotToSay')
  preferNotToSay,
}

extension GenderExtension on Gender {
  String get displayName {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.genderQueer:
        return 'Genderqueer';
      case Gender.nonBinary:
        return 'Non-binary';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }
}
