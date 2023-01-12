import 'package:foom/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:foom/core/usecase/usecase.dart';
import 'package:foom/features/authentication/domain/entities/login.dart';
import 'package:foom/features/authentication/domain/repository/authentication_repository.dart';

class UserLogin implements UseCase<Login, LoginUserParam> {
  final AuthenticationRepository repository;
  UserLogin(this.repository);
  @override
  Future<Either<Failure, Login>> call(LoginUserParam param) async {
    return await repository.login(email: param.email, password: param.password);
  }
}

class LoginUserParam {
  final String email;
  final String password;
  LoginUserParam({
    required this.email,
    required this.password,
  });
}
