abstract class AuthenticationRepository {
  Future<void> signInWithMobileNumber({required String mobileNumber});
  Future<void> resendOTP({required String mobileNumber});
  Future<void> verifyOTP({required String otp});
  Future<void> signOut();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<void> resendOTP({required String mobileNumber}) {
    // TODO: implement resendOTP
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithMobileNumber({required String mobileNumber}) {
    // TODO: implement signInWithMobileNumber
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOTP({required String otp}) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
