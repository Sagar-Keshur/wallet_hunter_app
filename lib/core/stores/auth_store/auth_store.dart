import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../base_store/base_store.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore extends BaseStore with Store {
  _AuthStore();

  final PageController pageController = PageController();

  @observable
  int currentPage = 0;

  @observable
  String? mobileNumberError;

  bool getLoginState() {
    return false;
  }

  void onBackPressed() {}
}
