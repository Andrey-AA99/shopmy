import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';
import 'package:shopmy/features/shop/models/cart_item_model.dart';
import 'package:shopmy/features/shop/models/product_model.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: const BoxDecoration(
        color: TColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            ()=> Row(
              children: [
                TCircularIcon(
                  icon: Iconsax.minus_copy,
                  backgroundColor: TColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: TColors.black,
                  onPressed: ()=>controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -=1,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(width: TSizes.spaceBtwItems),
                TCircularIcon(
                  icon: Iconsax.add_copy,
                  backgroundColor: TColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: TColors.black,
                  onPressed: ()=> controller.productQuantityInCart.value +=1,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: controller.productQuantityInCart.value < 1 ? null : ()=> controller.addToCart(product),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.warning,
              side: const BorderSide(color: TColors.warning),
            ),
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
