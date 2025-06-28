import 'dart:async';

import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';

import '../../../dependency_manager/dependency_manager.dart';
import '../base_store/base_store.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore extends BaseStore with Store {
  _AppStore({required this.dependencyManager}) {
    unawaited(initializeApp());
  }

  final DependencyManager dependencyManager;

  @observable
  bool initialized = false;

  @observable
  bool isLoading = false;

  Future<void> initializeApp() async {
    initialized = false;

    if (dependencyManager.initialized) {
      initialized = true;
      return;
    }

    try {
      await dependencyManager.init();
      initialized = true;
    } on Exception catch (e, stackTrace) {
      getIt<Logger>().e(
        'DEPENDENCY ERROR WENT HERE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
