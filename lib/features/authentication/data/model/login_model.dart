import 'package:foom/features/authentication/domain/entities/login.dart';

class LoginModel extends Login {
  LoginModel(
      {required String email,
      String? displayName,
      DateTime? loginDate,
      String? token})
      : super(
          email: email,
          displayName: displayName,
          loginDate: loginDate,
          token: token,
        );

  Login toEntities() => Login(
      displayName: displayName,
      email: email,
      loginDate: loginDate,
      token: token);
}
