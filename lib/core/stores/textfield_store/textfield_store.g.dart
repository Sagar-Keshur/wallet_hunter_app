// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'textfield_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppTextFieldStore on _AppTextFieldStore, Store {
  late final _$hasFocusAtom = Atom(
    name: '_AppTextFieldStore.hasFocus',
    context: context,
  );

  @override
  bool get hasFocus {
    _$hasFocusAtom.reportRead();
    return super.hasFocus;
  }

  @override
  set hasFocus(bool value) {
    _$hasFocusAtom.reportWrite(value, super.hasFocus, () {
      super.hasFocus = value;
    });
  }

  late final _$hasErrorAtom = Atom(
    name: '_AppTextFieldStore.hasError',
    context: context,
  );

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  @override
  String toString() {
    return '''
hasFocus: ${hasFocus},
hasError: ${hasError}
    ''';
  }
}
