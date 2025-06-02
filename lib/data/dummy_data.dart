import 'dart:ffi';

import 'package:shopmy/features/shop/models/brand_category_model.dart';
import 'package:shopmy/features/shop/models/brand_model.dart';
import 'package:shopmy/features/shop/models/category_model.dart';
import 'package:shopmy/features/shop/models/product_attribute_model.dart';
import 'package:shopmy/features/shop/models/product_category_model.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/features/shop/models/product_variation_model.dart';

import '../utils/constants/enums.dart';
import '../utils/constants/image_strings.dart';

class TDummyData {
  static final List<CategoryModel> categories = [
    CategoryModel(id: '4',
        name: 'Трикотаж',
        image: TImages.shirtsCategory,
        isFeatured: true),
    CategoryModel(id: '5',
        name: 'Обувь',
        image: TImages.shirtsCategory,
        isFeatured: true),
    CategoryModel(id: '6',
        name: 'Аксессуары',
        image: TImages.shirtsCategory,
        isFeatured: true),

    CategoryModel(id: '7',
        name: 'Брюки классика',
        image: TImages.trousersCategory,
        parantId: '2',
        isFeatured: false),
    CategoryModel(id: '7',
        name: 'Брюки спорт',
        image: TImages.trousersCategory,
        parantId: '2',
        isFeatured: false),

    CategoryModel(id: '7',
        name: 'Пиджаки классика',
        image: TImages.jacketsCategory,
        parantId: '1',
        isFeatured: false),
    CategoryModel(id: '7',
        name: 'Пиджаки повседневные',
        image: TImages.jacketsCategory,
        parantId: '1',
        isFeatured: false),
  ];

  static final List<BrandModel> brands = [
    BrandModel(id: '3',
        name: 'Mango',
        image: TImages.bagsCategory,
        productsCount: 300,
        isFeatured: true),
    BrandModel(id: '4',
        name: 'Massimo Duti',
        image: TImages.bagsCategory,
        productsCount: 300,
        isFeatured: true)
  ];

  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '1', categoryId: '2'),
    BrandCategoryModel(brandId: '1', categoryId: '3'),
    BrandCategoryModel(brandId: '1', categoryId: '4'),
    BrandCategoryModel(brandId: '1', categoryId: '5'),
    BrandCategoryModel(brandId: '1', categoryId: '6'),
    BrandCategoryModel(brandId: '2', categoryId: '1'),
    BrandCategoryModel(brandId: '2', categoryId: '2'),
    BrandCategoryModel(brandId: '2', categoryId: '3'),
    BrandCategoryModel(brandId: '2', categoryId: '4'),
    BrandCategoryModel(brandId: '2', categoryId: '5'),
    BrandCategoryModel(brandId: '2', categoryId: '6'),
    BrandCategoryModel(brandId: '3', categoryId: '1'),
    BrandCategoryModel(brandId: '3', categoryId: '2'),
    BrandCategoryModel(brandId: '3', categoryId: '3'),
    BrandCategoryModel(brandId: '3', categoryId: '4'),
    BrandCategoryModel(brandId: '3', categoryId: '5'),
    BrandCategoryModel(brandId: '3', categoryId: '6'),
    BrandCategoryModel(brandId: '4', categoryId: '1'),
    BrandCategoryModel(brandId: '4', categoryId: '2'),
    BrandCategoryModel(brandId: '4', categoryId: '3'),
    BrandCategoryModel(brandId: '4', categoryId: '4'),
    BrandCategoryModel(brandId: '4', categoryId: '5'),
    BrandCategoryModel(brandId: '4', categoryId: '6'),
  ];

  static final List<ProductCategoryModel> productCategory = [
    ProductCategoryModel(productId: '05', categoryId: '1'),
    ProductCategoryModel(productId: '06', categoryId: '2'),
    ProductCategoryModel(productId: '07', categoryId: '3'),
    ProductCategoryModel(productId: '08', categoryId: '2'),
    ProductCategoryModel(productId: '09', categoryId: '4'),
  ];

}