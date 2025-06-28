// import 'package:firebase_auth/firebase_auth.dart';

// import '../../dependency_manager/dependency_manager.dart';
// import '../exceptions/app_exception.dart';
// import '../utils/api_helper.dart';

// abstract class AuthenticationRepository {
//   Future<String> signInWithPhoneNumber({required String phoneNumber});
//   Future<User> verifyOTP({required String verificationId, required String otp});
//   Future<String> resendOTP({required String phoneNumber});
//   Future<void> signOut();
//   User? get currentUser;
// }

// class AuthenticationRepositoryImpl implements AuthenticationRepository {
//   AuthenticationRepositoryImpl({
//     FirebaseAuth? firebaseAuth,
//     FirestoreHelper? firestoreHelper,
//   }) : _firebaseAuth = firebaseAuth ?? getIt<FirebaseAuth>(),
//        _firestoreHelper = firestoreHelper ?? getIt<FirestoreHelper>();

//   final FirebaseAuth _firebaseAuth;
//   final FirestoreHelper _firestoreHelper;

//   @override
//   Future<String> signInWithPhoneNumber({required String phoneNumber}) {
//     return _firestoreHelper.safeFirestoreCall(() async {
//       String verificationId = '';
//       await _firebaseAuth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (phoneAuthCredential) {
//           print('verificationCompleted');
//         },
//         verificationFailed: (e) {
//           print('verificationFailed');
//         },
//         codeSent: (id, resendToken) {
//           print('codeSent');
//           verificationId = id;
//           print('verificationId: $verificationId');
//         },
//         codeAutoRetrievalTimeout: (id) {
//           verificationId = id;
//         },
//       );

//       // final ConfirmationResult result = await _firebaseAuth
//       //     .signInWithPhoneNumber(phoneNumber);
//       // return result.verificationId;
//       return verificationId;
//     });
//   }

//   @override
//   Future<User> verifyOTP({
//     required String verificationId,
//     required String otp,
//   }) {
//     return _firestoreHelper.safeFirestoreCall(() async {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otp,
//       );
//       final result = await _firebaseAuth.signInWithCredential(credential);
//       if (result.user == null) {
//         throw AppException(message: 'Invalid OTP');
//       }
//       return result.user!;
//     });
//   }

//   @override
//   Future<String> resendOTP({required String phoneNumber}) {
//     return _firestoreHelper.safeFirestoreCall(() async {
//       final ConfirmationResult result = await _firebaseAuth
//           .signInWithPhoneNumber(phoneNumber);
//       return result.verificationId;
//     });
//   }

//   @override
//   Future<void> signOut() {
//     return _firestoreHelper.safeFirestoreCall(() async {
//       await _firebaseAuth.signOut();
//     });
//   }

//   @override
//   User? get currentUser => _firebaseAuth.currentUser;
// }
