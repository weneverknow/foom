import 'package:foom/features/product/domain/repository/product_repository.dart';

import '../entities/product.dart';

class FetchProductsFromFirestore {
  final ProductRepository repository;
  FetchProductsFromFirestore(this.repository);
  Stream<List<Product?>?> fetch() {
    return repository.fetchProductsFromFirestore();
  }
}
