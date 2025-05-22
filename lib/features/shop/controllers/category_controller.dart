import 'package:get/get.dart';
import 'package:shopmy/data/repositories/categories/category_repository.dart';
import 'package:shopmy/data/repositories/products/product_repository.dart';
import 'package:shopmy/features/shop/models/category_model.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/popops/loaders.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();


  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;


  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }


  Future<void> fetchCategories() async{
    try{
      //Show loader while loading categories
      isLoading.value = true;


      final categories = await _categoryRepository.getAllCategories();


      //Update the categories list
      allCategories.assignAll(categories);


      //Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parantId.isEmpty).take(8).toList());



    }catch(e){
      TLoaders.errorSnackBar(title: 'Ой ошибка', message: e.toString());
    }
  }

  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async{
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId,limit: limit);
    return products;
  }


}