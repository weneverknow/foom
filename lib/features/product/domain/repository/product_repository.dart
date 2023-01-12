import 'package:dartz/dartz.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:foom/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> fetchProducts();
  Stream<List<Product?>?> fetchProductsFromFirestore();
}
