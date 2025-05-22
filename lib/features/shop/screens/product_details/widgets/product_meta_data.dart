import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/images/circular_image.dart';
import 'package:shopmy/common/widgets/texts/product_title_text.dart';
import 'package:shopmy/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:shopmy/features/shop/controllers/product/product_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/constants/enums.dart';
import 'package:shopmy/utils/constants/image_strings.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Цена и цена со скидкой
        Row(
          children: [
            ///sale
            TRoundedContainer(
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
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),

            ///цена
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
          ],
        ),

        ///Название
        TProductTitleText(title: product.title),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        ///В наличии
        Row(
          children: [
            const TProductTitleText(title: 'Статус'),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        ///Категория

        Row(
          children: [
            const TCircularImage(
                image: TImages.jacketsCategory,
                width: 40,
                height: 40,
                isNetworkImage: false),
            TBrandTitleWithVerifiedIcon(
              title: product.brand!.name,
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
