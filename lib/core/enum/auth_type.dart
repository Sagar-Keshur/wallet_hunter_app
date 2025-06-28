enum AuthType {
  emailAndPassword,
  google,
  apple,
}

extension AuthTypeExtension on AuthType {
  String get name {
    switch (this) {
      case AuthType.emailAndPassword:
        return 'Email and Password';
      case AuthType.google:
        return 'Google';
      case AuthType.apple:
        return 'Apple';
    }
  }

  static AuthType fromName(String name) {
    switch (name) {
      case 'Email and Password':
        return AuthType.emailAndPassword;
      case 'Google':
        return AuthType.google;
      case 'Apple':
        return AuthType.apple;
      default:
        throw Exception('Invalid AuthType name');
    }
  }
}
