import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/categories/category_card.dart';
import 'package:shopmy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shopmy/common/widgets/success_screen/success_screen.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';
import 'package:shopmy/features/personalization/controllers/address_controller.dart';
import 'package:shopmy/features/personalization/screens/settings/settings.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';
import 'package:shopmy/features/shop/controllers/product/checkout_controller.dart';
import 'package:shopmy/features/shop/screens/home/home.dart';
import 'package:shopmy/utils/constants/enums.dart';
import 'package:shopmy/utils/constants/image_strings.dart';
import 'package:shopmy/utils/popops/full_screen_loader.dart';
import 'package:shopmy/utils/popops/loaders.dart';

import '../../../../data/repositories/orders/order_repository.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Ой ошибка', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Сохраняем заказ', TImages.loadAnimation);

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(id: UniqueKey().toString(),
          status: OrderStatus.shipping,
          userId: userId,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList());

      await orderRepository.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(() =>
          SuccessScreen(image: TImages.successfulPaymentIcon,
              title: 'Оплата прошла!',
              subTitle: 'Ваши товары направляются к вам',
              onPressed: () => Get.off(() => const SettingsScreen())));
    }catch(e){
      TLoaders.errorSnackBar(title: 'Ошибка!', message: e.toString());
    }
  }
}