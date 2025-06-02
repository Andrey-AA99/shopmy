import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopmy/features/shop/controllers/product/variation_controller.dart';
import 'package:shopmy/features/shop/models/cart_item_model.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/constants/enums.dart';
import 'package:shopmy/utils/local_storage/storage_utility.dart';
import 'package:shopmy/utils/popops/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;
  final TLocalStorage storage = TLocalStorage.instance();


  void addToCart(ProductModel product) {

    if (product.productType == ProductType.variable.toString() &&
      variationController.selectedVariation.value.id.isEmpty) {
    TLoaders.customToast(message: 'Выберите вариант');
    return;
    }

    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Выберите кол-во');
      return;
    }

    if(product.productType == ProductType.variable.toString()){
      if(productQuantityInCart.value>variationController.selectedVariation.value.stock){
        TLoaders.warningSnackBar(
            title: 'Ой!', message: 'Товара не хватает на складе');
        return;
      }
    }else{
      if(productQuantityInCart.value>product.stock){
        TLoaders.warningSnackBar(
            title: 'Ой!', message: 'Товара не хватает на складе');
        return;
      }
    }

    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        TLoaders.warningSnackBar(
            title: 'Ой!', message: 'Выбранный вариант не в наличии');
        return;
      }
    } else {
      if (product.stock < 1) {
        TLoaders.warningSnackBar(
            title: 'Ой!', message: 'Выбранный товар не в наличии');
        return;
      }
    }



    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if(index >= 0){
      cartItems[index].quantity = selectedCartItem.quantity;
    }else{
      cartItems.add(selectedCartItem);
    }

    updateCart();
    TLoaders.customToast(message: 'Продукт добавлен в корзину');
  }

  void addOneToCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if(index >= 0){
      cartItems[index].quantity +=1;
    }else{
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

    if(index >= 0){
      if(cartItems[index].quantity > 1){
        cartItems[index].quantity -=1;
      }else{
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title: 'Удалить товар из корзины?',
      middleText: 'Вы уверены, что хотите удалить товар из корзины?',
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Товар удален из корзины');
        Get.back();
      },
      onCancel: ()=> Get.back()
    );
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbNail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart(){
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for(var item in cartItems){
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems(){
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    storage.saveData('cartItems', cartItemStrings);
  }

  void loadCartItems(){
      final cartItemStrings = storage.readData<List<dynamic>>('cartItems');
      if(cartItemStrings != null){
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String,dynamic>)));
      updateCartTotals();
      }

  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems.where((item) => item.productId == productId).fold(0, (previousValue,element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId,String variationId){
    final foundItem = cartItems.firstWhere((item) => item.productId == productId && item.variationId == variationId, orElse: ()=> CartItemModel.empty());
    return foundItem.quantity;
  }
  void clearCart(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void updateAlreadyAddedProductCount(ProductModel product) {
    if(product.productType == ProductType.single.toString()){
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    }else{
      final variationId = variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);
      }else{
        productQuantityInCart.value = 0;
      }
    }
  }

}
