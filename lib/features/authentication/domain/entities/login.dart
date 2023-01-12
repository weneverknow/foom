import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String email;
  final String? displayName;
  final DateTime? loginDate;
  final String? token;
  Login({required this.email, this.displayName, this.loginDate, this.token});

  static String? accessToken;

  Login copyWith({
    String? displayName,
  }) =>
      Login(
        email: email,
        loginDate: loginDate,
        token: token,
        displayName: displayName ?? this.displayName,
      );
  @override
  // TODO: implement props
  List<Object?> get props => [loginDate, displayName, token, email];
}
