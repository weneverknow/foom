import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:foom/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}

class NoParam extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
