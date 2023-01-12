part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  // const RegistrationState();

  // @override
  // List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationSuccess extends RegistrationState {
  final Login login;
  RegistrationSuccess(this.login);
  @override
  // TODO: implement props
  List<Object?> get props => [login];
}

class RegistrationFailed extends RegistrationState {
  final String message;
  RegistrationFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
