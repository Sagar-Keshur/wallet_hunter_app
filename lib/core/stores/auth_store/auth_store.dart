import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';

import '../../../dependency_manager/dependency_manager.dart';
import '../../../router/route_helper.dart';
import '../../enum/state_type.dart';
import '../../exceptions/app_exception.dart';
import '../../utils/constants.dart';
import '../../utils/shared_preferences_helper.dart';
import '../base_store/base_store.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore extends BaseStore with Store {
  _AuthStore({
    FirebaseAuth? firebaseAuth,
    SharedPreferencesHelper? sharedPreferencesHelper,
  }) : _firebaseAuth = firebaseAuth ?? getIt<FirebaseAuth>(),
       _sharedPreferencesHelper =
           sharedPreferencesHelper ?? getIt<SharedPreferencesHelper>() {
    _initAuthState();
  }

  final FirebaseAuth _firebaseAuth;
  final SharedPreferencesHelper _sharedPreferencesHelper;
  final Logger _logger = getIt<Logger>();

  PageController pageController = PageController();
  Timer? _resendTimer;

  @observable
  int currentPage = 0;

  @observable
  String mobileNumber = '';

  @observable
  String otpCode = '';

  @observable
  bool isOtpSent = false;

  @observable
  String verificationId = '';

  @observable
  int resendTimerSeconds = 0;

  @observable
  bool canResendOtp = true;

  @observable
  Status sendOtpStatus = Status.initial;

  @observable
  Status verifyOtpStatus = Status.initial;

  @observable
  Status resendOtpStatus = Status.initial;

  @observable
  bool isLoggedIn = false;

  @computed
  String get formattedMobileNumber {
    if (mobileNumber.isEmpty) {
      return '';
    }
    if (mobileNumber.length <= 5) {
      return mobileNumber;
    }
    return '${mobileNumber.substring(0, 5)} ${mobileNumber.substring(5)}';
  }

  @computed
  String get resendTimerText {
    if (resendTimerSeconds <= 0) {
      return 'Resend';
    }
    final minutes = resendTimerSeconds ~/ 60;
    final seconds = resendTimerSeconds % 60;
    return 'Resend in ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @computed
  bool get isResendTimerActive => resendTimerSeconds > 0;

  @computed
  bool get isMobileNumberValid {
    if (mobileNumber.isEmpty) {
      return false;
    }
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');
    return mobileRegex.hasMatch(mobileNumber);
  }

  @computed
  bool get isOtpComplete {
    return otpCode.length == 6;
  }

  @action
  void _validateOtp() {
    if (otpCode.isEmpty) {
      throw AppException(message: 'Please enter a valid 6-digit OTP');
    }
    if (otpCode.length != 6) {
      throw AppException(message: 'Please enter a complete 6-digit OTP');
    }
    if (verificationId.isEmpty) {
      throw AppException(
        message: 'Verification session expired. Please try again.',
      );
    }
  }

  @action
  void _validateMobileNumber() {
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');
    if (!mobileRegex.hasMatch(mobileNumber)) {
      throw AppException(
        message: 'Please enter a valid 10-digit mobile number',
      );
    }
  }

  @action
  Future<void> sendOtp() async {
    if (!isMobileNumberValid) {
      return;
    }

    await tryCatchWrapper(
      action: () async {
        sendOtpStatus = Status.loading;
        _validateMobileNumber();
        final phoneNumber = '+91$mobileNumber';

        _logger.d('Sending OTP to: $phoneNumber');

        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) {
            _logger.d('verificationCompleted');
            verificationId = phoneAuthCredential.verificationId ?? '';
            sendOtpStatus = Status.loaded;
          },
          verificationFailed: (e) {
            _logger.e('verificationFailed: $e');
            sendOtpStatus = Status.error;
          },
          codeSent: (verificationId, resendToken) {
            _logger.d('codeSent with verificationId: $verificationId');
            this.verificationId = verificationId;
            isOtpSent = true;
            startResendTimer();
            _navigateToOtpPage();
            sendOtpStatus = Status.loaded;
          },
          timeout: kDefaultOtpTimeout,
          codeAutoRetrievalTimeout: (verificationId) {
            _logger.d('codeAutoRetrievalTimeout: $verificationId');
            this.verificationId = verificationId;
            sendOtpStatus = Status.loaded;
          },
        );
      },
      errorAction: (error) async {
        _logger.e('Send OTP failed: $error');
        sendOtpStatus = Status.error;
      },
    );
  }

  @action
  Future<void> verifyOtp() async {
    if (!isOtpComplete) {
      _logger.d('OTP not complete: ${otpCode.length}/6');
      return;
    }

    await tryCatchWrapper(
      action: () async {
        verifyOtpStatus = Status.loading;

        _logger
          ..d('Starting OTP verification')
          ..d('OTP Code: "$otpCode" (length: ${otpCode.length})')
          ..d(
            'Verification ID: "$verificationId" (length: ${verificationId.length})',
          );

        // Validate OTP before proceeding
        _validateOtp();

        // Additional safety check
        if (otpCode.isEmpty || verificationId.isEmpty) {
          _logger.e('Empty OTP or verification ID detected');
          throw AppException(
            message: 'Invalid verification data. Please try again.',
          );
        }

        _logger.d('Creating PhoneAuthProvider credential');
        final result = await _firebaseAuth.signInWithCredential(
          PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: otpCode,
          ),
        );

        _logger.d('Firebase Auth result: ${result.user?.uid}');

        if (result.user?.uid.isEmpty ?? true) {
          throw AppException(message: 'Try again');
        }
        await _sharedPreferencesHelper.setUserId(result.user!.uid);
        await _sharedPreferencesHelper.setLoginStateTrue();
        verifyOtpStatus = Status.loaded;
        _logger.d('OTP verification successful');
        _initAuthState();
      },
      errorAction: (error) async {
        verifyOtpStatus = Status.error;
        _logger.e('OTP verification failed: $error');
      },
    );
  }

  @action
  Future<void> resendOtp() async {
    if (!canResendOtp) {
      return;
    }

    _logger.d('Resending OTP to: $mobileNumber');
    await tryCatchWrapper(
      action: () async {
        resendOtpStatus = Status.loading;
        final phoneNumber = '+91$mobileNumber';
        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) {
            _logger.d('verificationCompleted');
            resendOtpStatus = Status.error;
          },
          verificationFailed: (e) {
            _logger.d('verificationFailed $e');
            resendOtpStatus = Status.error;
          },
          codeSent: (verificationId, resendToken) {
            _logger.d('codeSent');
            this.verificationId = verificationId;
            isOtpSent = true;
            startResendTimer();
            resendOtpStatus = Status.loaded;
          },
          timeout: kDefaultOtpTimeout,
          codeAutoRetrievalTimeout: (verificationId) {
            _logger.d('codeAutoRetrievalTimeout');
            this.verificationId = verificationId;
            resendOtpStatus = Status.loaded;
          },
        );
      },
      errorAction: (error) async {
        resendOtpStatus = Status.error;
      },
    );
  }

  @action
  void startResendTimer() {
    canResendOtp = false;
    resendTimerSeconds = 60;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimerSeconds > 0) {
        resendTimerSeconds--;
      } else {
        canResendOtp = true;
        timer.cancel();
      }
    });
  }

  Future<bool> onBackPressed() async {
    if (currentPage == 0) {
      return true;
    }
    await pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    return false;
  }

  @action
  void _navigateToOtpPage() {
    unawaited(
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  User? get currentUser => _firebaseAuth.currentUser;

  @action
  void _initAuthState() {
    if (currentUser != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  }

  @action
  Future<void> logout() async {
    await tryCatchWrapper(
      action: () async {
        isLoggedIn = false;
        getIt<RouteHelper>().showAuthGuardScreenAndRemoveEverything();
        await _firebaseAuth.signOut();
      },
      errorAction: (error) async {
        _logger.e('Logout failed: $error');
      },
    );
  }

  @action
  void dispose() {
    _resendTimer?.cancel();
    _resendTimer = null;
    mobileNumber = '';
    otpCode = '';
    isOtpSent = false;
    canResendOtp = true;
    resendTimerSeconds = 0;
    verificationId = '';
    sendOtpStatus = Status.initial;
    verifyOtpStatus = Status.initial;
    resendOtpStatus = Status.initial;
    currentPage = 0;
  }
}
