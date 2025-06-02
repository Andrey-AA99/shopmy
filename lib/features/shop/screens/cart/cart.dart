import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/loaders/animation_loader.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';
import 'package:shopmy/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:shopmy/navigation_menu.dart';
import 'package:shopmy/utils/constants/image_strings.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Корзина', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
            text: 'Корзина пуста',
            animation: TImages.addToCartAnimation,
            showAction: true,
            actionText: 'Давайте добавим товары',
            onActionPressed: () => Get.off(() => const NavigationMenu()));

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),

                /// Items in Cart
                child: TCartItems()),
          );
        }
      }),

      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                style:
                    ElevatedButton.styleFrom(backgroundColor: TColors.warning),
                child: Obx(
                    () => Text('К оплате ${controller.totalCartPrice.value}')),
              ),
            ),
    );
  }
}
