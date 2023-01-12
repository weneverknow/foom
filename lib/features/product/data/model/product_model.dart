import 'package:foom/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {String? docId,
      int? id,
      String? name,
      String? imageUrl,
      int? price,
      bool? haveDisc,
      double? disc,
      bool? isBestSeller,
      String? type,
      String? desc})
      : super(
          docId: docId,
          id: id,
          name: name,
          imageUrl: imageUrl,
          price: price,
          haveDisc: haveDisc,
          disc: disc,
          isBestSeller: isBestSeller,
          type: Product.toEnum(type ?? ''),
          desc: desc,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json, String docId) =>
      ProductModel(
        docId: docId,
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        price: json['price'],
        haveDisc: json['haveDisc'],
        disc: json['disc'],
        isBestSeller: json['isBestSeller'],
        type: json['type'],
        desc: json['desc'],
      );

  Product toEntities() => Product(
        docId: docId,
        id: id,
        name: name,
        imageUrl: imageUrl,
        price: price,
        haveDisc: haveDisc,
        disc: disc,
        isBestSeller: isBestSeller,
        type: type,
        desc: desc,
      );
}
