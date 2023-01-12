import 'package:foom/core/exceptions/exceptions.dart';
import 'package:foom/core/firestore/firestore_service.dart';
import 'package:foom/features/product/data/model/product_model.dart';
import 'package:foom/features/product/data/product_data.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();
  Stream<List<ProductModel?>?> fetchProductsFromFirestore();
}

class ProductDataSourceImpl implements ProductDataSource {
  final FirestoreService firestoreService;
  ProductDataSourceImpl(this.firestoreService);
  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      return firestoreService.getCollection(
          path: "products",
          //sort: (lhs, rhs) => lhs.id.compareTo(rhs!.id!),
          builder: ((data, documentId) {
            return ProductModel.fromJson(data, documentId);
          }));
      // return dataProduct
      //     .map((e) => ProductModel.fromJson(e, "${e['id']}"))
      //     .toList();
    } catch (e) {
      print("[ProductDatasource] error ${e.toString()}");
      throw DatabaseException(e.toString());
    }
  }

  @override
  Stream<List<ProductModel?>?> fetchProductsFromFirestore() {
    return firestoreService.collectionStream(
        path: "products",
        sort: (lhs, rhs) => lhs!.id!.compareTo(rhs!.id!),
        builder: ((data, documentId) {
          return ProductModel.fromJson(data, documentId);
        }));
  }
}

// abstract class FetchProductDataSource {
//   Future<List<ProductModel>> fetchProducts();
// }

// class FetchProductDataSourceFirebase implements FetchProductDataSource {
//   @override
//   Future<List<ProductModel>> fetchProducts() {
//     // TODO: implement fetchProducts
//     throw UnimplementedError();
//   }
// }

// class FetchProductDataSourceApi implements FetchProductDataSource {
//   @override
//   Future<List<ProductModel>> fetchProducts() {
//     // TODO: implement fetchProducts
//     throw UnimplementedError();
//   }
// }
