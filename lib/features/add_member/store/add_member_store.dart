import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/enum/gender_type.dart';
import '../../../core/enum/state_type.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/models/family_model/family_model.dart';
import '../../../core/stores/base_store/base_store.dart';
import '../../../core/utils/api_helper.dart';
import '../../../core/utils/string_utils.dart';
import '../../../dependency_manager/dependency_manager.dart';
import '../../../router/route_helper.dart';
import '../../dashboard/store/dashboard_store.dart';

part 'add_member_store.g.dart';

class AddMemberStore = _AddMemberStore with _$AddMemberStore;

abstract class _AddMemberStore extends BaseStore with Store {
  _AddMemberStore({
    required this.dashboardStore,
    FirebaseStorage? firebaseStorage,
    FirestoreHelper? firestoreHelper,
    FirestoreRepository<FamilyModel>? familyRepository,
  }) : _firebaseStorage = firebaseStorage ?? getIt<FirebaseStorage>(),
       _firestoreHelper = firestoreHelper ?? getIt<FirestoreHelper>(),
       _familyRepository =
           familyRepository ?? getIt<FirestoreRepository<FamilyModel>>();

  final DashboardStore dashboardStore;

  late final FirebaseStorage _firebaseStorage;
  late final FirestoreHelper _firestoreHelper;
  late final FirestoreRepository<FamilyModel> _familyRepository;

  final PageController pageController = PageController();

  final int totalPages = 5;

  @observable
  int currentPage = 0;

  // Personal Information
  @observable
  String firstName = '';

  @observable
  String middleName = '';

  @observable
  String lastName = '';

  @observable
  DateTime? birthDate;

  @observable
  int age = 0;

  @observable
  Gender? gender;

  @observable
  String maritalStatus = '';

  @observable
  String qualification = '';

  @observable
  String occupation = '';

  @observable
  String exactNatureOfDuties = '';

  @observable
  String bloodGroup = '';

  @observable
  File? photo;

  // Relation with Family Head
  @observable
  String relationWithFamilyHead = '';

  // Contact Information
  @observable
  String phoneNumber = '';

  @observable
  String alternativeNumber = '';

  @observable
  String landlineNumber = '';

  @observable
  String emailId = '';

  @observable
  String socialMediaLink = '';

  // Current Address
  @observable
  String country = '';

  @observable
  String state = '';

  @observable
  String district = '';

  @observable
  String city = '';

  @observable
  String streetName = '';

  @observable
  String landmark = '';

  @observable
  String buildingName = '';

  @observable
  String doorNumber = '';

  @observable
  String flatNumber = '';

  @observable
  String pincode = '';

  // Native Place
  @observable
  String nativeCity = '';

  @observable
  String nativeState = '';

  @observable
  Status addMemberStatus = Status.initial;

  void onBackPressed() {
    if (currentPage == 0) {
      getIt<RouteHelper>().pop();
      return;
    }
    onPreviousPage();
  }

  @action
  void onNextPage() {
    unawaited(
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @action
  void onPreviousPage() {
    unawaited(
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @action
  Future<void> onAddMember() async {
    final familyModel = dashboardStore.familyModel;

    await tryCatchWrapper(
      action: () async {
        if (familyModel == null) {
          throw AppException(code: 'Error', message: 'Family model not found');
        }
        addMemberStatus = Status.loading;

        String? photoUrl;
        if (photo != null) {
          photoUrl = await uploadPhoto();
        }

        final member = getMemberMode(photoUrl);
        familyModel.copyWith(
          members: familyModel.members..add(member),
          familyMemberPhoneNumbers: familyModel.familyMemberPhoneNumbers
            ..add(phoneNumber),
        );

        await _familyRepository.updateDocument(
          id: familyModel.memberId,
          model: familyModel,
        );

        addMemberStatus = Status.loaded;
        dashboardStore.familyModel = familyModel;
        getIt<RouteHelper>().pop();
      },
      errorAction: (error) async {
        addMemberStatus = Status.error;
      },
    );
  }

  MemberModel getMemberMode(String? photoUrl) {
    return MemberModel(
      id: generateGuid(),
      age: age,
      photo: photoUrl,
      alternativeNumber: alternativeNumber,
      birthDate: birthDate,
      bloodGroup: bloodGroup,
      buildingName: buildingName,
      city: city,
      country: country,
      district: district,
      doorNumber: doorNumber,
      emailId: emailId,
      exactNatureOfDuties: exactNatureOfDuties,
      firstName: firstName,
      gender: gender?.name,
      lastName: lastName,
      landmark: landmark,
      maritalStatus: maritalStatus,
      middleName: middleName,
      occupation: occupation,
      flatNumber: flatNumber,
      landlineNumber: landlineNumber,
      nativeCity: nativeCity,
      nativeState: nativeState,
      pincode: pincode,
      phoneNumber: phoneNumber,
      relationWithFamilyHead: relationWithFamilyHead,
      socialMediaLink: socialMediaLink,
      state: state,
      streetName: streetName,
      qualification: qualification,
    );
  }

  @action
  Future<String?> uploadPhoto() {
    return _firestoreHelper.safeFirestoreCall(() async {
      final ref = _firebaseStorage.ref().child('family_members/$phoneNumber');
      await ref.putFile(photo!);
      return ref.getDownloadURL();
    });
  }
}
