import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/base_store/base_store.dart';

part 'onboarding_store.g.dart';

class OnboardingStore = _OnboardingStore with _$OnboardingStore;

abstract class _OnboardingStore extends BaseStore with Store {
  _OnboardingStore();

  final PageController pageController = PageController();

  @observable
  int currentPage = 0;

  void onBackPressed() {}
}
