part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  // const RegistrationEvent();

  // @override
  // List<Object> get props => [];
}

class RegistrationCreateAccount extends RegistrationEvent {
  final String email;
  final String password;
  RegistrationCreateAccount(this.email, this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class RegistrationProcessReset extends RegistrationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
