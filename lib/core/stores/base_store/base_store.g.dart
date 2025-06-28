// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseStore on _BaseStore, Store {
  late final _$errorMessageAtom = Atom(
    name: '_BaseStore.errorMessage',
    context: context,
  );

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$statusAtom = Atom(name: '_BaseStore.status', context: context);

  @override
  Status get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(Status value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$tryCatchWrapperAsyncAction = AsyncAction(
    '_BaseStore.tryCatchWrapper',
    context: context,
  );

  @override
  Future<void> tryCatchWrapper({
    required Future<dynamic> Function() action,
    required Future<dynamic> Function(dynamic) errorAction,
    bool showSnackbar = true,
  }) {
    return _$tryCatchWrapperAsyncAction.run(
      () => super.tryCatchWrapper(
        action: action,
        errorAction: errorAction,
        showSnackbar: showSnackbar,
      ),
    );
  }

  late final _$_handleErrorAsyncAction = AsyncAction(
    '_BaseStore._handleError',
    context: context,
  );

  @override
  Future<void> _handleError({
    required dynamic error,
    required Future<dynamic> Function(dynamic) errorAction,
    required bool showSnackbar,
  }) {
    return _$_handleErrorAsyncAction.run(
      () => super._handleError(
        error: error,
        errorAction: errorAction,
        showSnackbar: showSnackbar,
      ),
    );
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
status: ${status}
    ''';
  }
}
