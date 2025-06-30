// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on _DashboardStoreBase, Store {
  late final _$familyModelAtom = Atom(
    name: '_DashboardStoreBase.familyModel',
    context: context,
  );

  @override
  FamilyModel? get familyModel {
    _$familyModelAtom.reportRead();
    return super.familyModel;
  }

  @override
  set familyModel(FamilyModel? value) {
    _$familyModelAtom.reportWrite(value, super.familyModel, () {
      super.familyModel = value;
    });
  }

  late final _$isFamilyHeadAtom = Atom(
    name: '_DashboardStoreBase.isFamilyHead',
    context: context,
  );

  @override
  bool get isFamilyHead {
    _$isFamilyHeadAtom.reportRead();
    return super.isFamilyHead;
  }

  @override
  set isFamilyHead(bool value) {
    _$isFamilyHeadAtom.reportWrite(value, super.isFamilyHead, () {
      super.isFamilyHead = value;
    });
  }

  late final _$_DashboardStoreBaseActionController = ActionController(
    name: '_DashboardStoreBase',
    context: context,
  );

  @override
  Future<void> getFamilyModel() {
    final _$actionInfo = _$_DashboardStoreBaseActionController.startAction(
      name: '_DashboardStoreBase.getFamilyModel',
    );
    try {
      return super.getFamilyModel();
    } finally {
      _$_DashboardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
familyModel: ${familyModel},
isFamilyHead: ${isFamilyHead}
    ''';
  }
}
