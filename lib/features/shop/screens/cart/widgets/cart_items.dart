import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSection),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              /// Cart Item
              TCartItem(
                cartItem: item,
              ),
              if (showAddRemoveButton)
                const SizedBox(height: TSizes.spaceBtwItems),

              /// Add Remove Button Row with total Price
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// (for the extra space)
                        const SizedBox(width: 70),

                        /// Add Remove Buttons
                        TProductQuantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),

                    /// -- Product Total Price
                    TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}
