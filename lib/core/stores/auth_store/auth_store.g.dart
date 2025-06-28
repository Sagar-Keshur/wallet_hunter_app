// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<String>? _$formattedMobileNumberComputed;

  @override
  String get formattedMobileNumber =>
      (_$formattedMobileNumberComputed ??= Computed<String>(
        () => super.formattedMobileNumber,
        name: '_AuthStore.formattedMobileNumber',
      )).value;
  Computed<String>? _$resendTimerTextComputed;

  @override
  String get resendTimerText => (_$resendTimerTextComputed ??= Computed<String>(
    () => super.resendTimerText,
    name: '_AuthStore.resendTimerText',
  )).value;
  Computed<bool>? _$isResendTimerActiveComputed;

  @override
  bool get isResendTimerActive =>
      (_$isResendTimerActiveComputed ??= Computed<bool>(
        () => super.isResendTimerActive,
        name: '_AuthStore.isResendTimerActive',
      )).value;
  Computed<bool>? _$isMobileNumberValidComputed;

  @override
  bool get isMobileNumberValid =>
      (_$isMobileNumberValidComputed ??= Computed<bool>(
        () => super.isMobileNumberValid,
        name: '_AuthStore.isMobileNumberValid',
      )).value;
  Computed<bool>? _$isOtpCompleteComputed;

  @override
  bool get isOtpComplete => (_$isOtpCompleteComputed ??= Computed<bool>(
    () => super.isOtpComplete,
    name: '_AuthStore.isOtpComplete',
  )).value;

  late final _$currentPageAtom = Atom(
    name: '_AuthStore.currentPage',
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

  late final _$mobileNumberAtom = Atom(
    name: '_AuthStore.mobileNumber',
    context: context,
  );

  @override
  String get mobileNumber {
    _$mobileNumberAtom.reportRead();
    return super.mobileNumber;
  }

  @override
  set mobileNumber(String value) {
    _$mobileNumberAtom.reportWrite(value, super.mobileNumber, () {
      super.mobileNumber = value;
    });
  }

  late final _$otpCodeAtom = Atom(name: '_AuthStore.otpCode', context: context);

  @override
  String get otpCode {
    _$otpCodeAtom.reportRead();
    return super.otpCode;
  }

  @override
  set otpCode(String value) {
    _$otpCodeAtom.reportWrite(value, super.otpCode, () {
      super.otpCode = value;
    });
  }

  late final _$isOtpSentAtom = Atom(
    name: '_AuthStore.isOtpSent',
    context: context,
  );

  @override
  bool get isOtpSent {
    _$isOtpSentAtom.reportRead();
    return super.isOtpSent;
  }

  @override
  set isOtpSent(bool value) {
    _$isOtpSentAtom.reportWrite(value, super.isOtpSent, () {
      super.isOtpSent = value;
    });
  }

  late final _$verificationIdAtom = Atom(
    name: '_AuthStore.verificationId',
    context: context,
  );

  @override
  String get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  late final _$resendTimerSecondsAtom = Atom(
    name: '_AuthStore.resendTimerSeconds',
    context: context,
  );

  @override
  int get resendTimerSeconds {
    _$resendTimerSecondsAtom.reportRead();
    return super.resendTimerSeconds;
  }

  @override
  set resendTimerSeconds(int value) {
    _$resendTimerSecondsAtom.reportWrite(value, super.resendTimerSeconds, () {
      super.resendTimerSeconds = value;
    });
  }

  late final _$canResendOtpAtom = Atom(
    name: '_AuthStore.canResendOtp',
    context: context,
  );

  @override
  bool get canResendOtp {
    _$canResendOtpAtom.reportRead();
    return super.canResendOtp;
  }

  @override
  set canResendOtp(bool value) {
    _$canResendOtpAtom.reportWrite(value, super.canResendOtp, () {
      super.canResendOtp = value;
    });
  }

  late final _$sendOtpStatusAtom = Atom(
    name: '_AuthStore.sendOtpStatus',
    context: context,
  );

  @override
  Status get sendOtpStatus {
    _$sendOtpStatusAtom.reportRead();
    return super.sendOtpStatus;
  }

  @override
  set sendOtpStatus(Status value) {
    _$sendOtpStatusAtom.reportWrite(value, super.sendOtpStatus, () {
      super.sendOtpStatus = value;
    });
  }

  late final _$verifyOtpStatusAtom = Atom(
    name: '_AuthStore.verifyOtpStatus',
    context: context,
  );

  @override
  Status get verifyOtpStatus {
    _$verifyOtpStatusAtom.reportRead();
    return super.verifyOtpStatus;
  }

  @override
  set verifyOtpStatus(Status value) {
    _$verifyOtpStatusAtom.reportWrite(value, super.verifyOtpStatus, () {
      super.verifyOtpStatus = value;
    });
  }

  late final _$resendOtpStatusAtom = Atom(
    name: '_AuthStore.resendOtpStatus',
    context: context,
  );

  @override
  Status get resendOtpStatus {
    _$resendOtpStatusAtom.reportRead();
    return super.resendOtpStatus;
  }

  @override
  set resendOtpStatus(Status value) {
    _$resendOtpStatusAtom.reportWrite(value, super.resendOtpStatus, () {
      super.resendOtpStatus = value;
    });
  }

  late final _$isLoggedInAtom = Atom(
    name: '_AuthStore.isLoggedIn',
    context: context,
  );

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$sendOtpAsyncAction = AsyncAction(
    '_AuthStore.sendOtp',
    context: context,
  );

  @override
  Future<void> sendOtp() {
    return _$sendOtpAsyncAction.run(() => super.sendOtp());
  }

  late final _$verifyOtpAsyncAction = AsyncAction(
    '_AuthStore.verifyOtp',
    context: context,
  );

  @override
  Future<void> verifyOtp() {
    return _$verifyOtpAsyncAction.run(() => super.verifyOtp());
  }

  late final _$resendOtpAsyncAction = AsyncAction(
    '_AuthStore.resendOtp',
    context: context,
  );

  @override
  Future<void> resendOtp() {
    return _$resendOtpAsyncAction.run(() => super.resendOtp());
  }

  late final _$logoutAsyncAction = AsyncAction(
    '_AuthStore.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_AuthStoreActionController = ActionController(
    name: '_AuthStore',
    context: context,
  );

  @override
  void _validateOtp() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore._validateOtp',
    );
    try {
      return super._validateOtp();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _validateMobileNumber() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore._validateMobileNumber',
    );
    try {
      return super._validateMobileNumber();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startResendTimer() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore.startResendTimer',
    );
    try {
      return super.startResendTimer();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _navigateToOtpPage() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore._navigateToOtpPage',
    );
    try {
      return super._navigateToOtpPage();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _initAuthState() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore._initAuthState',
    );
    try {
      return super._initAuthState();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore.dispose',
    );
    try {
      return super.dispose();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
mobileNumber: ${mobileNumber},
otpCode: ${otpCode},
isOtpSent: ${isOtpSent},
verificationId: ${verificationId},
resendTimerSeconds: ${resendTimerSeconds},
canResendOtp: ${canResendOtp},
sendOtpStatus: ${sendOtpStatus},
verifyOtpStatus: ${verifyOtpStatus},
resendOtpStatus: ${resendOtpStatus},
isLoggedIn: ${isLoggedIn},
formattedMobileNumber: ${formattedMobileNumber},
resendTimerText: ${resendTimerText},
isResendTimerActive: ${isResendTimerActive},
isMobileNumberValid: ${isMobileNumberValid},
isOtpComplete: ${isOtpComplete}
    ''';
  }
}
