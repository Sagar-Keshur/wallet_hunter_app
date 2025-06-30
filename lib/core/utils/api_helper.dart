// ignore_for_file: unnecessary_async

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../dependency_manager/dependency_manager.dart';
import '../exceptions/app_exception.dart';
import '../exceptions/no_internet_exception.dart';
import '../models/base_model/base_model.dart';
import '../models/family_model/family_model.dart';
import '../services/network/network_info.dart';

class FirestoreHelper {
  FirestoreHelper({NetworkInfo? networkInfo})
    : _networkInfo = networkInfo ?? getIt<NetworkInfo>();

  final NetworkInfo _networkInfo;

  Future<T> safeFirestoreCall<T>(Future<T> Function() firestoreCall) async {
    try {
      final bool hasInternetAccess = await _networkInfo.isConnected;
      if (!hasInternetAccess) {
        throw NoInternetException();
      }
      final result = await firestoreCall();
      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint('From Firestore Helper $e');
      throw AppException(
        message: e.message ?? 'An error occurred with FirebaseAuth',
        code: e.code,
      );
    } on FirebaseException catch (e) {
      debugPrint('From Firestore Helper $e');
      if (e.code == 'unavailable') {
        throw NoInternetException();
      } else {
        throw AppException(
          message: e.message ?? 'An error occurred with Firestore',
          code: e.code,
        );
      }
    } on Exception catch (e) {
      if (e is NoInternetException) {
        throw NoInternetException(e.message);
      } else if (e is FirebaseAuthException) {
        debugPrint('From Firestore Helper $e');
        rethrow;
      } else {
        debugPrint('From Firestore Helper $e');
        throw AppException();
      }
    }
  }
}

class FirestoreRepository<T extends BaseModel> {
  FirestoreRepository({
    required this.collectionPath,
    required this.fromFirestore,
    required this.toFirestore,
    FirestoreHelper? firestoreHelper,
  }) : _collectionRef = getIt<FirebaseFirestore>().collection(collectionPath),
       _firestoreHelper = firestoreHelper ?? getIt<FirestoreHelper>();

  final String collectionPath;
  final CollectionReference _collectionRef;
  final T Function(DocumentSnapshot documentSnapshot) fromFirestore;
  final Map<String, Object?> Function(T model) toFirestore;
  final FirestoreHelper _firestoreHelper;

  Future<T?> getDocumentById(String id) {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint('$collectionPath | Getting document by id: $id');
      final docSnapshot = await _collectionRef.doc(id).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        return fromFirestore(docSnapshot);
      }
      return null;
    });
  }

  Future<void> addDocument(T model) async {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint('$collectionPath | Adding document: $model');
      await _collectionRef.add(toFirestore(model));
      debugPrint('Document added');
    });
  }

  Future<void> addDocumentWithId({required String id, required T model}) async {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint('$collectionPath | Adding document with id: $id');
      await _collectionRef.doc(id).set(toFirestore(model));
      debugPrint('Document added with id: $id');
    });
  }

  Future<void> updateDocument({required String id, required T model}) async {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint('$collectionPath | Updating document with id: $id');
      await _collectionRef.doc(id).update(toFirestore(model));
      debugPrint('Document updated with id: $id');
    });
  }

  Future<void> deleteDocument(String id) async {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint('$collectionPath | Deleting document with id: $id');
      await _collectionRef.doc(id).delete();
      debugPrint('Document deleted with id: $id');
    });
  }

  Future<List<T>> getAllDocuments() async {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint('$collectionPath | Getting all documents');
      final querySnapshot = await _collectionRef.get();
      debugPrint('Query snapshot: ${querySnapshot.docs}');
      return querySnapshot.docs.map(fromFirestore).toList();
    });
  }

  Future<List<T>> getAllDocumentById({
    required String key,
    required Object value,
  }) {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint('$collectionPath | Getting all documents by id: $key, $value');
      final querySnapshot = await _collectionRef
          .where(key, isEqualTo: value)
          .get();
      debugPrint('Query snapshot: ${querySnapshot.docs}');
      return querySnapshot.docs.map(fromFirestore).toList();
    });
  }

  Future<FamilyModel?> getFamilyModelByMobileNumber(String mobileNumber) {
    return _firestoreHelper.safeFirestoreCall(() async {
      debugPrint(
        '$collectionPath | Getting family model by mobile number: $mobileNumber',
      );
      final querySnapshot = await _collectionRef
          .where('familyMemberPhoneNumbers', arrayContains: mobileNumber)
          .get();
      debugPrint('Query snapshot: ${querySnapshot.docs}');
      return querySnapshot.docs.map(fromFirestore).toList().firstOrNull
          as FamilyModel?;
    });
  }
}
