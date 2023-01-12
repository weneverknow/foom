import 'package:foom/core/exceptions/exceptions.dart';
import 'package:foom/features/product/data/datasource/product_datasource.dart';
import 'package:foom/features/product/domain/entities/product.dart';
import 'package:foom/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:foom/features/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;
  ProductRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<Product>>> fetchProducts() async {
    try {
      final result = await dataSource.fetchProducts();
      List<Product> products =
          result.map((model) => model.toEntities()).toList();
      return right(products);
    } on DatabaseException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Stream<List<Product?>?> fetchProductsFromFirestore() {
    return dataSource
        .fetchProductsFromFirestore()
        .map((models) => models?.map((model) => model?.toEntities()).toList())
        .asBroadcastStream();
  }
}
