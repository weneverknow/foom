import 'package:foom/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:foom/core/usecase/usecase.dart';
import 'package:foom/features/authentication/domain/repository/authentication_repository.dart';

class UserLogout implements UseCase<void, NoParam> {
  final AuthenticationRepository repository;
  UserLogout(this.repository);
  @override
  Future<Either<Failure, void>> call(NoParam param) async {
    return await repository.logout();
  }
}
