mixin ValidationMixin {
  String? emailValidator(String? email) {
    if (email?.isNotEmpty ?? false) {
      if (_isEmailValid(email)) {
        return null;
      } else {
        return 'Please enter a valid email address';
      }
    } else {
      return 'Please enter your email address';
    }
  }

  String? signInPasswordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Please enter your password';
    } else {
      return null;
    }
  }

  String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Please enter your password';
    } else {
      if (password.length < 6) {
        return 'Password should be a minimum 6 characters';
      } else {
        return null;
      }
    }
  }

  String? newPasswordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Please enter new password';
    } else {
      if (password.length < 6) {
        return 'Password should be a minimum 6 characters';
      } else {
        return null;
      }
    }
  }

  String? nameValidator(String? name) {
    // final whiteSpace = RegExp(r'^\s*$');
    final validCharacters = RegExp(r'^[a-zA-Z\s]+$');

    if (name != null) {
      if (name.isEmpty) {
        return 'Please enter a name in the field.';
      } else if (name.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else if (name.contains('  ')) {
        return 'Only one space allowed after the name.';
      } else if (!validCharacters.hasMatch(name)) {
        return 'Name should only be in alphabets';
      } else {
        return null;
      }
    } else {
      return 'Please enter your name';
    }
  }

  String? confirmPasswordValidator(String? value, String? password) {
    if (value?.isNotEmpty ?? false) {
      if (password == value) {
        return null;
      }
      return "Password and ReType Password doesn't match";
    } else {
      return 'Please enter ReType password';
    }
  }

  // Onboarding specific validators
  String? ageValidator(String? age) {
    if (age?.isNotEmpty ?? false) {
      final ageValue = int.tryParse(age!);
      if (ageValue == null) {
        return 'Please enter a valid age';
      } else if (ageValue < 1 || ageValue > 120) {
        return 'Please enter a valid age between 1 and 120';
      } else {
        return null;
      }
    } else {
      return 'Please enter your age';
    }
  }

  String? phoneValidator(String? phone) {
    if (phone?.isNotEmpty ?? false) {
      if (phone!.length == 10 && RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
        return null;
      } else {
        return 'Please enter a valid 10-digit mobile number';
      }
    } else {
      return 'Please enter your phone number';
    }
  }

  String? landlineValidator(String? landline) {
    if (landline?.isNotEmpty ?? false) {
      if (RegExp(r'^\d{6,15}$').hasMatch(landline!)) {
        return null;
      } else {
        return 'Please enter a valid landline number';
      }
    } else {
      return 'Please enter your landline number';
    }
  }

  String? pincodeValidator(String? pincode) {
    if (pincode?.isNotEmpty ?? false) {
      if (pincode!.length == 6 && RegExp(r'^\d{6}$').hasMatch(pincode)) {
        return null;
      } else {
        return 'Please enter a valid 6-digit pincode';
      }
    } else {
      return 'Please enter your pincode';
    }
  }

  String? requiredFieldValidator(String? value, String fieldName) {
    if (value?.isNotEmpty ?? false) {
      return null;
    } else {
      return 'Please enter your $fieldName';
    }
  }

  String? urlValidator(String? url) {
    if (url?.isNotEmpty ?? false) {
      final urlPattern = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
      );
      if (urlPattern.hasMatch(url!)) {
        return null;
      } else {
        return 'Please enter a valid URL';
      }
    } else {
      return 'Please enter your social media link';
    }
  }

  bool _isEmailValid(String? email) {
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(pattern.toString());
    return email != null ? regex.hasMatch(email) : false;
  }
}
