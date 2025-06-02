import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/features/shop/screens/product_details/product_details.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailsScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(
            product.id);
        return Container(
          decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? TColors.warning : TColors.dark,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.cardRadiusMg),
                  bottomRight:
                  Radius.circular(TSizes.productImageRadius))),
          child: SizedBox(
            width: TSizes.iconLg * 1.2,
            height: TSizes.iconLg * 1.2,
            child: Center(
                child: productQuantityInCart > 0 ? Text(
                    productQuantityInCart.toString(), style: Theme
                    .of(context)
                    .textTheme.bodyLarge!
                    .apply(color: TColors.white)) : const Icon(
                  Iconsax.add_copy,
                  color: TColors.white,
                )),
          ),
        );
      }),
    );
  }
}
