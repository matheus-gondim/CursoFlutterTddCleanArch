abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get isFormValidStrem;
  Stream get isLoadingStrem;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}
