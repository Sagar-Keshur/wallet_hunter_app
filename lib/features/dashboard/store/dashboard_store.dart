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
      },
      errorAction: (error) async {
        unawaited(SnackbarUtils.currentState.read<AuthStore>().logout());
      },
    );
  }
}
