import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{

  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @observable
  bool obscurePassword = true;

  @action
  void togglePasswordVisibility() => obscurePassword = !obscurePassword;

  @observable
  bool loading = false;

  @action
  Future<void> login() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    loading = false;
  }

  @computed
  bool get isEmailValid => email.length > 6;

  @computed
  bool get isPasswordValid => password.length > 6;

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : null;

}