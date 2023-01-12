import 'package:foom/features/product/domain/entities/product.dart';

const dataProduct = [
  {
    "id": 1,
    "name": "Apple Burst - 30ML 30MG",
    "price": 110000,
    "haveDisc": false,
    "isBestSeller": false,
    "type": "liquid",
    "desc": "Flavour : APPLE ICE MINT, SaltNiotine: 30 MG, Volume: 30 ML",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/catalogappleburst_1024x1024@2x.png?v=1625740996",
  },
  {
    "id": 2,
    "name": "Beverage Series - Ice Tea",
    "price": 110000,
    "haveDisc": false,
    "isBestSeller": false,
    "type": "liquid",
    "desc":
        "menghadirkan varian dengan sensasi kesegaran seperti minuman favorit lo. Mana nih minuman favoritmu?",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/IcedTea-Vapemagz_1024x1024@2x.png?v=1659941786",
  },
  {
    "id": 3,
    "name": "Icy Menthol Original",
    "price": 110000,
    "haveDisc": true,
    "disc": 0.2,
    "isBestSeller": true,
    "type": "liquid",
    "desc": "Flavour: Menthol, Niotne: 30MG, Volume: 30ML",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/IcyMenthol-Vapemagz_1024x1024@2x.png?v=1659942168",
  },
  {
    "id": 4,
    "name": "Java Kretek",
    "price": 110000,
    "isBestSeller": true,
    "haveDisc": false,
    "type": "liquid",
    "desc": "Flavour: Cengkeh, Niotne: 30MG, Volume: 30ML",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/NEWCATALOG-06_1024x1024@2x.png?v=1632387448",
  },
  {
    "id": 5,
    "name": "Foom Pod X Hot Pink",
    "price": 160000,
    "isBestSeller": false,
    "haveDisc": false,
    "type": "starterkit",
    "desc":
        "The proper way to pronounce the name is “FOOM X” and the reason is simple: it  stands for “More”, not the letter X. Because we give you more improvement & experience; this is why FOOM used the X",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/PODXBOXPINKDEVICE_1024x1024@2x.png?v=1669617601",
  },
  {
    "id": 6,
    "name": "Foom Pod X Black",
    "price": 160000,
    "isBestSeller": true,
    "haveDisc": false,
    "type": "starterkit",
    "desc":
        "The proper way to pronounce the name is “FOOM X” and the reason is simple: it  stands for “More”, not the letter X. Because we give you more improvement & experience; this is why FOOM used the X",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/1.1_e55db580-879e-484a-b1e4-9e5f73548a5c_1024x1024@2x.jpg?v=1665653836",
  },
  {
    "id": 7,
    "name": "Foom Pod X Folkative",
    "price": 279000,
    "isBestSeller": true,
    "haveDisc": false,
    "type": "starterkit",
    "desc":
        "The proper way to pronounce the name is “FOOM X” and the reason is simple: it  stands for “More”, not the letter X. Because we give you more improvement & experience; this is why FOOM used the X",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/PODXBOX-FolkativeBlack-IcyMenthol_7b6100d5-7274-420c-8b33-7b90e44db0d9_1080x.png?v=1671090636",
  },
  {
    "id": 8,
    "name": "Foom Refillable",
    "price": 100000,
    "isBestSeller": false,
    "haveDisc": false,
    "type": "cartridge",
    "desc":
        "Paket kemasan LEBIH HEMAT, HEMAT WAKTU dan HEMAT BIAYA pastinya. Cukup dengan satu kali ongkir kamu bisa menikmatin FOOM tanpa batas, ga ada lagi susah nyetok selama sudah nyetok FOOM di rumah, di kantor, di tas bahkan di mobil pakai yang isi isi 4. Selain lebih simple, dengan design yg elegant, km bisa bawa paket ini ke tongkrongan!!",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/NEWCATALOG-40_2_cf12bc61-9e4f-46c1-af75-cd23c7eb5c58_1024x1024@2x.png?v=1625583915",
  },
  {
    "id": 9,
    "name": "Foom Refillable 2 Pcs",
    "price": 50000,
    "isBestSeller": false,
    "haveDisc": false,
    "type": "cartridge",
    "desc":
        "Paket kemasan LEBIH HEMAT, HEMAT WAKTU dan HEMAT BIAYA pastinya. Cukup dengan satu kali ongkir kamu bisa menikmatin FOOM tanpa batas, ga ada lagi susah nyetok selama sudah nyetok FOOM di rumah, di kantor, di tas bahkan di mobil pakai yang isi isi 4. Selain lebih simple, dengan design yg elegant, km bisa bawa paket ini ke tongkrongan!!",
    "imageUrl":
        "https://cdn.shopify.com/s/files/1/0274/4496/9506/products/NEWCATALOG-09_30499ffc-0610-4ec0-8dd0-35972b72ff32_1024x1024@2x.png?v=1614916934",
  },
];

final category = [
  {
    "code": "liquid",
    "value": "Liquid",
    "icon": "assets/icons/Box-02-256.png",
  },
  {
    "code": "starterkit",
    "value": "Starter Kit",
    "icon": "assets/icons/Pill-256.png"
  },
  {
    "code": "cartridge",
    "value": "Cartridge",
    "icon": "assets/icons/Product-Box-256.png"
  }
];
