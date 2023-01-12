import 'package:firebase_auth/firebase_auth.dart';
import 'package:foom/core/exceptions/exceptions.dart';
import 'package:foom/features/authentication/data/datasource/firebase_authentication.dart';
import 'package:foom/features/authentication/data/model/login_model.dart';

abstract class AuthenticationDatasource {
  Future<LoginModel> login(String email, String password);
  Future<void> logout();
  Future<LoginModel> createAccount({
    required String email,
    required String password,
  });
}

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final FirebaseAuthentication auth;
  AuthenticationDatasourceImpl(this.auth);
  @override
  Future<LoginModel> login(String email, String password) async {
    try {
      final user = await auth.signInWithEmail(email: email, password: password);
      if (user == null) {
        throw FirebaseAuthenticationException("User not found");
      }
      return LoginModel(
          displayName: user.displayName,
          email: email,
          loginDate: DateTime.now(),
          token: user.uid);
    } on FirebaseAuthenticationException catch (e) {
      throw FirebaseAuthenticationException(e.message);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw FirebaseAuthenticationException("Sign out failed");
    }
  }

  @override
  Future<LoginModel> createAccount(
      {required String email, required String password}) async {
    try {
      var user =
          await auth.createAccountWithEmail(email: email, password: password);
      if (user == null) {
        throw FirebaseAuthenticationException("Created new user failed.");
      }

      return LoginModel(
          displayName: user.displayName,
          email: email,
          loginDate: DateTime.now(),
          token: user.uid);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationException(
          e.message ?? "something went wrong.");
    }
  }
}
