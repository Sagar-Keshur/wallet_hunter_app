// ignore_for_file: avoid_catches_without_on_clauses, type_annotate_public_apis, avoid_annotating_with_dynamic, strict_top_level_inference

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';

import '../../../dependency_manager/dependency_manager.dart';
import '../../enum/state_type.dart';
import '../../exceptions/app_exception.dart';
import '../../exceptions/no_internet_exception.dart';
import '../../utils/snackbar_utils.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  _BaseStore();

  @observable
  String errorMessage = 'Error';

  @observable
  Status status = Status.initial;

  @action
  Future<void> tryCatchWrapper({
    required Future Function() action,
    required Future Function(dynamic error) errorAction,
    bool showSnackbar = true,
  }) async {
    try {
      status = Status.loading;
      await action();
      status = Status.loaded;
    } catch (e) {
      await _handleError(
        error: e,
        errorAction: errorAction,
        showSnackbar: showSnackbar,
      );
    }
  }

  @action
  Future<void> _handleError({
    required error,
    required Future Function(dynamic error) errorAction,
    required bool showSnackbar,
  }) async {
    status = Status.error;
    await errorAction(error);

    if (error is NoInternetException) {
      errorMessage = error.message;
      SnackbarUtils.showErrorSnackBar(error.message);
    } else if (error is PlatformException) {
      getIt<Logger>().e('FunctionException', error: error);
    } else if (error is AppException) {
      errorMessage = error.message;
      getIt<Logger>().e('AppException', error: error);
      SnackbarUtils.showErrorSnackBar(error.message);
    } else {
      getIt<Logger>().e('Unknown Exception', error: error);
      SnackbarUtils.showErrorSnackBar('Something went wrong!');
    }
  }
}
