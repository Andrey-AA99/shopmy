

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopmy/features/shop/models/product_attribute_model.dart';
import 'package:shopmy/features/shop/models/product_variation_model.dart';

import 'brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  bool? isFeatured;
  BrandModel? brand;
  String thumbNail;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.thumbNail,
    required this.id,
    required this.stock,
    this.sku,
    required this.price,
    required this.title,
    this.date,
    this.salePrice = 0.0,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    required this.productType,
    this.productAttributes,
    this.productVariations
  });

  static ProductModel empty() =>
      ProductModel(id: '',
          title: '',
          stock: 0,
          price: 0,
          productType: '',
      thumbNail: '');

  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand,
      'Descryption': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null ? productAttributes!.map((
          e) => e.toJson()).toList() : [],
      'ProductVariations': productVariations != null ? productVariations!.map((
          e) => e.toJson()).toList() : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String,dynamic>> document) {
    if(document.data() == null) return ProductModel.empty();
    final data = document.data()!;


    return ProductModel(id: document.id,
        sku: data['SKU'],
        stock: data['Stock'] ?? 0,
        price: double.parse((data['Price'] ?? 0.0).toString()),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        title: data['Title'],
        productType: data['ProductType'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      categoryId: data['CategoryId'] ?? '',
      description: data['Descryption'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']): [],
      thumbNail: data['Thumbnail']??'',
      productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),


    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document){
    final data = document.data() as Map<String,dynamic>;
    return ProductModel(id: document.id,
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      title: data['Title'],
      productType: data['ProductType'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      categoryId: data['CategoryId'] ?? '',
      description: data['Descryption'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']): [],
      thumbNail: data['Thumbnail']??'',
      productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),

    );
  }



}