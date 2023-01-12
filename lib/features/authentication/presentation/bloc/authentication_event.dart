part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  // const AuthenticationEvent();

  // @override
  // List<Object> get props => [];
}

class AuthenticationWithEmail extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationWithEmail(this.email, this.password);

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class AuthenticationProcessReset extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationSignOut extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationCreateAccount extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationCreateAccount(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class AuthenticationRelogin extends AuthenticationEvent {
  final Login login;
  AuthenticationRelogin(this.login);
  @override
  List<Object?> get props => [login];
}
