import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:foom/core/usecase/usecase.dart';
import 'package:foom/features/authentication/domain/entities/login.dart';
import 'package:foom/features/authentication/domain/usecase/create_account.dart';
import 'package:foom/features/authentication/domain/usecase/user_login.dart';
import 'package:foom/features/authentication/domain/usecase/user_logout.dart';
import 'package:foom/service_locator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationWithEmail>(_signIn);
    on<AuthenticationProcessReset>(_reset);
    on<AuthenticationSignOut>(_logout);
    on<AuthenticationCreateAccount>(_register);
    on<AuthenticationRelogin>(_relogin);
  }

  final UserLogin _userLogin = sl<UserLogin>();
  final UserLogout _userLogout = sl<UserLogout>();
  final CreateAccount _createAccount = sl<CreateAccount>();
  Future<void> _relogin(
      AuthenticationRelogin event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationSuccess(event.login));
  }

  Future<void> _logout(
      AuthenticationSignOut event, Emitter<AuthenticationState> emit) async {
    final result = await _userLogout.call(NoParam());
    result.fold((l) => emit(AuthenticationFailed(l.message)),
        (r) => AuthenticationInitial());
  }

  Future<void> _signIn(
      AuthenticationWithEmail event, Emitter<AuthenticationState> emit) async {
    print("[AuthenticationBloc] _signIn executed");
    final loggedIn = await _userLogin
        .call(LoginUserParam(email: event.email, password: event.password));
    loggedIn.fold((l) => emit(AuthenticationFailed(l.message)),
        (r) => emit(AuthenticationSuccess(r)));
  }

  Future<void> _reset(AuthenticationProcessReset event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInitial());
  }

  Future<void> _register(AuthenticationCreateAccount event,
      Emitter<AuthenticationState> emit) async {
    final result = await _createAccount
        .call(LoginUserParam(email: event.email, password: event.password));
    result.fold((l) => emit(AuthenticationFailed(l.message)),
        (r) => emit(AuthenticationSuccess(r)));
  }
}
