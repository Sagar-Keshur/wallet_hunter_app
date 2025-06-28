import 'package:mobx/mobx.dart';

part 'textfield_store.g.dart';

class AppTextFieldStore = _AppTextFieldStore with _$AppTextFieldStore;

abstract class _AppTextFieldStore with Store {
  @observable
  bool hasFocus = false;

  @observable
  bool hasError = false;
}
