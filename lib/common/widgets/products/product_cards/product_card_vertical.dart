import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/common/widgets/favourite_icon/favourite_icon.dart';
import 'package:shopmy/common/widgets/products/cart/product_cart_add_to_cart_button.dart';
import 'package:shopmy/features/shop/controllers/product/product_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';

import '../../../../features/shop/screens/product_details/product_details.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../containers/rounded_container.dart';
import '../../images/rounded_image.dart';
import '../../icons/t_circular_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_with_verified_icon.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final controller = ProductController.instance;
    final salePercentage =controller.calculateSalePercentage(product.price, product.salePrice);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product:product ,)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: TColors.white,
        ),
        child: Column(
          children: [
            ///скидка, кнопка избранное, фото
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.xs),
              backgroundColor: TColors.light,
              child: Stack(
                children: [
                  ///Картинка
                  Center(
                    child: TRoundedImage(
                      imageUrl: product.thumbNail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  ///скидка
                  if(salePercentage != null)
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                  Positioned(
                      top: 0,
                      right: 0,
                      child: TFavouriteIcon(productId: product.id,))
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            ///ОПИСАНИЕ
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleWithVerifiedIcon(
                    title: product.brand!.name,
                  ),
                ],
              ),
            ),
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Price
                Flexible(
                  child: Column(
                    children: [
                      if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                        Padding(
                            padding: const EdgeInsets.only(left: TSizes.sm),
                            child: Text(product.price.toString(),
                            style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),),),


                      Padding(
                          padding: const EdgeInsets.only(left: TSizes.sm),
                          child: TProductPriceText(price: controller.getProductPrice(product))),
                    ],)
                  ),


                ProductCardAddToCartButton(product: product)
              ],
            )
          ],
        ),
      ),
    );
  }
}
