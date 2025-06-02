import 'dart:convert';

import 'package:get/get.dart';
import 'package:shopmy/data/repositories/products/product_repository.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/local_storage/storage_utility.dart';
import 'package:shopmy/utils/popops/loaders.dart';

class FavouritesController extends GetxController{
  static FavouritesController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  Future<void> initFavourites() async {
    final json = TLocalStorage.instance().readData('favourites');
    if(json != null){
      final storedFavourites = jsonDecode(json) as Map<String,dynamic>;
      favorites.assignAll(storedFavourites.map((key,value)=> MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId){
    return favorites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId){
    if(!favorites.containsKey(productId)){
      favorites[productId] = true;
      saveFavouriteToStorage();
      TLoaders.customToast(message: 'Товар добавлен в избранное');
    }else{
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavouriteToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Товар удален из избранного');
    }
  }

  void saveFavouriteToStorage(){
    final encodedFavourites = json.encode(favorites);
    TLocalStorage.instance().saveData('favourites',encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts()async{
    return await ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
  }
}