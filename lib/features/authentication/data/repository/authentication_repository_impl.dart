import 'package:foom/core/exceptions/exceptions.dart';
import 'package:foom/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:foom/features/authentication/domain/entities/login.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:foom/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource datasource;
  AuthenticationRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, Login>> login(
      {required String email, required String password}) async {
    try {
      final user = await datasource.login(email, password);
      return right(user.toEntities());
    } on FirebaseAuthenticationException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await datasource.logout();
      return right(() {});
    } on FirebaseAuthenticationException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Login>> createAccount(
      {required String email, required String password}) async {
    try {
      final login =
          await datasource.createAccount(email: email, password: password);
      return right(login.toEntities());
      //return right(null);
    } on FirebaseAuthenticationException catch (e) {
      return left(FetchFailure(e.message));
    }
  }
}
