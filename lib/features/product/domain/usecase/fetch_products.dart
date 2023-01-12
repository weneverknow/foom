import 'package:dartz/dartz.dart';
import 'package:foom/core/usecase/usecase.dart';
import 'package:foom/features/product/domain/entities/product.dart';
import 'package:foom/features/product/domain/repository/product_repository.dart';

import '../../../../core/failure/failure.dart';

class FetchProducts extends UseCase {
  final ProductRepository repository;
  FetchProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(param) async {
    return await repository.fetchProducts();
  }
}
