import 'package:foom/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:foom/core/usecase/usecase.dart';
import 'package:foom/features/authentication/domain/repository/authentication_repository.dart';

import '../entities/login.dart';
import 'user_login.dart';

class CreateAccount implements UseCase<Login, LoginUserParam> {
  final AuthenticationRepository repository;
  CreateAccount(this.repository);
  @override
  Future<Either<Failure, Login>> call(LoginUserParam param) async {
    return await repository.createAccount(
        email: param.email, password: param.password);
  }
}
