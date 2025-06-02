import 'package:get/get.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';
import 'package:shopmy/data/repositories/user/address_repository.dart';
import 'package:shopmy/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopmy/features/personalization/controllers/address_controller.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';
import 'package:shopmy/features/shop/controllers/product/checkout_controller.dart';
import 'package:shopmy/features/shop/controllers/product/variation_controller.dart';
import 'package:shopmy/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ForgetPasswordController());
    Get.put(VariationController());
    Get.put(CheckoutController());
    Get.put(AddressRepository());
    Get.put(CartController());
    Get.put(AddressController());
    Get.put(AuthenticationRepository());
  }
}
