import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foom/features/authentication/domain/entities/login.dart';
import 'package:foom/features/authentication/domain/usecase/create_account.dart';
import 'package:foom/features/authentication/domain/usecase/user_login.dart';
import 'package:foom/service_locator.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RegistrationCreateAccount>(_create);
    on<RegistrationProcessReset>(_reset);
  }

  final CreateAccount _createAccount = sl<CreateAccount>();

  Future<void> _create(
      RegistrationCreateAccount event, Emitter<RegistrationState> emit) async {
    final result = await _createAccount
        .call(LoginUserParam(email: event.email, password: event.password));
    result.fold((l) => emit(RegistrationFailed(l.message)),
        (r) => RegistrationSuccess(r));
  }

  Future<void> _reset(
      RegistrationProcessReset event, Emitter<RegistrationState> emit) async {
    emit(RegistrationInitial());
  }
}
