import 'package:equatable/equatable.dart';

enum ProductType { liquid, cartridge, starterkit }

class Product extends Equatable {
  final String? docId;
  final int? id;
  final String? name;
  final String? imageUrl;
  final int? price;
  final bool? haveDisc;
  final double? disc;
  final bool? isBestSeller;
  final ProductType? type;
  final String? desc;

  const Product({
    this.docId,
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.haveDisc,
    this.disc,
    this.isBestSeller,
    this.type,
    this.desc,
  });

  static ProductType toEnum(String val) {
    return val == "liquid"
        ? ProductType.liquid
        : val == "starterkit"
            ? ProductType.starterkit
            : ProductType.cartridge;
  }

  String get getType => type == ProductType.liquid
      ? "liquid"
      : type == ProductType.cartridge
          ? "cartridge"
          : "starterkit";

  factory Product.fromJson(Map<String, dynamic> json, String docId) {
    print("[Product] fromJson ${json['type']}");
    return Product(
      docId: json['docId'] == null ? docId : json['docId'],
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      haveDisc: json['haveDisc'],
      disc: json['disc'],
      isBestSeller: json['isBestSeller'],
      type: toEnum(json['type']),
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toFirestoreJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "haveDisc": haveDisc,
        "disc": disc,
        "isBestSeller": isBestSeller,
        "type": getType,
        "desc": desc,
        "docId": docId,
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "haveDisc": haveDisc,
        "disc": disc,
        "isBestSeller": isBestSeller,
        "type": getType,
        "desc": desc,
        "docId": docId,
      };

  @override
  String toString() {
    return "Product {docId: $docId, id: $id, name: $name, imageUrl: $imageUrl, price: $price, haveDisc: $haveDisc, disc: $disc, isBestSeller: $isBestSeller, type: $type, desc: $desc }";
  }

  @override
  List<Object?> get props => [
        docId,
        id,
        name,
        imageUrl,
        price,
        haveDisc,
        disc,
        isBestSeller,
        type,
        desc,
      ];
}
