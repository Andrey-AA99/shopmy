import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopmy/data/repositories/products/product_repository.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/popops/loaders.dart';

class AllProductsController extends GetxController{
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'По названию'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final isLoading = false.obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try{
      isLoading.value = true;
      if(query == null) return [];

      final products = await repository.fetchProductsByQuery(query);
      return products;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Ой ошибка', message: e.toString());
      return [];
    }finally{
      isLoading.value = false;
    }
  }

  void sortProducts (String sortOption){
    selectedSortOption.value = sortOption;

    switch(sortOption){
      case 'По названию' :
        products.sort((a,b)=> a.title.compareTo(b.title));
        break;
      case 'По убыванию цены':
        products.sort((a,b) => b.price.compareTo(a.price));
        break;
      case 'По возрастанию цены':
        products.sort((a,b) => a.price.compareTo(b.price));
        break;
      case 'По новизне':
        products.sort((a,b) => a.date!.compareTo(b.date!));
        break;
      case 'Скидка':
        products.sort((a,b) {
          if(b.salePrice>0){
            return b.salePrice.compareTo(a.salePrice);
          }else if (a.salePrice>0){
            return -1;
          }else{
            return 1;
          }
        });
        break;
      default:
        products.sort((a,b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products){
    this.products.assignAll(products);
    sortProducts('По названию');
  }

}