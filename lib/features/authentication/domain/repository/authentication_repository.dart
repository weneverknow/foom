import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:foom/features/authentication/domain/entities/login.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Login>> login(
      {required String email, required String password});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, Login>> createAccount(
      {required String email, required String password});
}
