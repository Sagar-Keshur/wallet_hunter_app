import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/models/family_model/family_model.dart';
import '../../../core/stores/auth_store/auth_store.dart';
import '../../../core/stores/base_store/base_store.dart';
import '../../../core/utils/api_helper.dart';
import '../../../core/utils/shared_preferences_helper.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../dependency_manager/dependency_manager.dart';

part 'dashboard_store.g.dart';

@observable
class DashboardStore = _DashboardStoreBase with _$DashboardStore;

abstract class _DashboardStoreBase extends BaseStore with Store {
  _DashboardStoreBase({
    FirestoreRepository<FamilyModel>? familyRepository,
    SharedPreferencesHelper? sharedPreferencesHelper,
  }) : _familyRepository =
           familyRepository ?? getIt<FirestoreRepository<FamilyModel>>(),
       _sharedPreferencesHelper =
           sharedPreferencesHelper ?? getIt<SharedPreferencesHelper>();

  late final FirestoreRepository<FamilyModel> _familyRepository;
  late final SharedPreferencesHelper _sharedPreferencesHelper;

  @observable
  FamilyModel? familyModel;

  @observable
  bool isFamilyHead = false;

  @observable
  int currentPageIndex = 0;

  @observable
  bool isFamilyTreeExporting = false;

  @action
  Future<void> getFamilyModel() {
    return tryCatchWrapper(
      action: () async {
        final userId = _sharedPreferencesHelper.getUserId();
        final mobileNumber = _sharedPreferencesHelper.getMobileNumber();
        familyModel = await _familyRepository.getDocumentById(userId);
        if (familyModel == null) {
          final result = await _familyRepository.getFamilyModelByMobileNumber(
            mobileNumber,
          );
          familyModel = result;
        }

        // Determine if current user is family head
        if (familyModel != null) {
          isFamilyHead = familyModel!.headPhoneNumber == mobileNumber;
        }
      },
      errorAction: (error) async {
        unawaited(SnackbarUtils.currentState.read<AuthStore>().logout());
      },
    );
  }

  @action
  Future<void> deleteMember(String memberId) {
    return tryCatchWrapper(
      action: () async {
        if (familyModel == null) {
          throw Exception('Family model not found');
        }

        if (!isFamilyHead) {
          throw Exception('Only family head can delete members');
        }

        final member = familyModel!.members.firstWhere(
          (member) => member.id == memberId,
        );

        final updatedMembers = familyModel!.members
            .where((member) => member.id != memberId)
            .toList();

        final familyMemberPhoneNumbers = familyModel!.familyMemberPhoneNumbers
            .where((phoneNumber) => phoneNumber != memberId)
            .toList();

        final updatedFamilyModel = familyModel!.copyWith(
          members: updatedMembers,
          familyMemberPhoneNumbers: familyMemberPhoneNumbers,
        );

        await _familyRepository.updateDocument(
          id: familyModel!.memberId,
          model: updatedFamilyModel,
        );

        familyModel = updatedFamilyModel;

        SnackbarUtils.showSuccessSnackBar(
          '${member.firstName} ${member.lastName} has been removed from the family!',
        );
      },
      errorAction: (error) async {
        SnackbarUtils.showErrorSnackBar('Failed to delete member');
      },
    );
  }
}
