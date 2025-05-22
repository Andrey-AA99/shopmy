import 'package:get/get.dart';
import 'package:shopmy/data/repositories/products/product_repository.dart';
import 'package:shopmy/features/shop/models/brand_model.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/popops/loaders.dart';

import '../../../../data/repositories/brands/brand_repository.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());


  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  Future<void> getFeaturedBrands() async {
    try{
      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));

    }catch(e){
      TLoaders.errorSnackBar(title: 'Ой ошибка',message: e.toString());
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(String categoryId)async{
    try{
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Ой ошибка',message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async{
    try{
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId);
      return products;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Ой ошибка', message: e.toString());
      return [];
    }


  }



}