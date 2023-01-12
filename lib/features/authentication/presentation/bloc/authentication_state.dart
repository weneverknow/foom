part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  // const AuthenticationState();

  // @override
  // List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final Login login;
  AuthenticationSuccess(this.login);
  @override
  List<Object?> get props => [login];
}

class AuthenticationFailed extends AuthenticationState {
  final String message;
  AuthenticationFailed(this.message);
  @override
  List<Object?> get props => [message];
}
