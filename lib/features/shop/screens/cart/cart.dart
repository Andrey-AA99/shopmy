import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/screens/cart/widgets/cart_items.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Корзина', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),

          /// Items in Cart
          child: TCartItems()),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          style: ElevatedButton.styleFrom(backgroundColor: TColors.warning),
          child: const Text('К оплате 14999'),
        ),
      ),
    );
  }
}
