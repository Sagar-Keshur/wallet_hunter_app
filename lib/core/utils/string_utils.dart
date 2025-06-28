import 'package:flutter/material.dart';

String? capitalizeFirstLetter(String? str) {
  return str != null ? '${str[0].toUpperCase()}${str.substring(1)}' : null;
}

bool isLeapYear(int year) {
  return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
}

String validateEmailFromRegEx(String email) {
  const String emailRegEx = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  if (!RegExp(emailRegEx).hasMatch(email)) {
    return 'Please enter a valid email address';
  }
  return '';
}

String validatePasswordFromRegEx(String password) {
  // Check if the password is empty
  if (password.isEmpty) {
    return 'Password cannot be empty.';
  }

  // Check if the password has at least one special character
  if (!RegExp(r'''[!@#$%^&*()_\-=+[\]{};:\'"\\|,.<>/?`~]''')
      .hasMatch(password)) {
    return 'Password must contain at least one special character.';
  }

  // Check if the password has at least 8 characters
  if (password.length < 8) {
    return 'Password must be at least 8 characters long.';
  }

  return ''; // Password is valid
}

DateTime? nullableDateFromJson(String? dateString) {
  return dateString == null ? null : DateTime.parse(dateString);
}

DateTime dateFromJson(String? dateString) {
  return nullableDateFromJson(dateString) ?? DateTime.now();
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

String timeOfDayToString(TimeOfDay time) {
  String addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  final String hourLabel = addLeadingZeroIfNeeded(time.hour);
  final String minuteLabel = addLeadingZeroIfNeeded(time.minute);

  return '$hourLabel:$minuteLabel';
}
