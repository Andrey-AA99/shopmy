import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/icons/t_circular_icon.dart';
import 'package:shopmy/common/widgets/images/rounded_image.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/features/shop/screens/product_details/widgets/bottom_add_to%20cart_widget.dart';
import 'package:shopmy/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:shopmy/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:shopmy/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:shopmy/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:shopmy/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:shopmy/utils/constants/enums.dart';
import 'package:shopmy/utils/constants/image_strings.dart';
import 'package:shopmy/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../utils/constants/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(children: [
          ///Слайдер
          TProductImageSlider(product: product),

          Padding(
            padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace),
            child: Column(
              children: [
                ///Рейтинг
                const TRatingAndShare(),

                ///Цена, Название, Категория
                TProductMetaData(product: product,),

                ///Атрибуты
                if(product.productType == ProductType.variable.toString())  TProductAttributes(product: product,),
                if(product.productType == ProductType.variable.toString()) const SizedBox(
                  height: TSizes.spaceBtwSection,
                ),

                ///
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()=> cartController.addToCart(product),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.warning,
                          shadowColor: TColors.warning),
                      child: const Text('Купить'),
                    )),
                const SizedBox(
                  height: TSizes.spaceBtwSection,
                ),

                const TSectionHeading(
                  title: 'Описание',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ReadMoreText(
                  product.description ?? '',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Делее',
                  trimExpandedText: 'Свернуть',
                  moreStyle:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  lessStyle:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),

                const Divider(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TSectionHeading(
                      title: 'Отзывы (58)',
                      onPressed: () {},
                      showActionButton: false,
                    ),
                    IconButton(
                        onPressed: () =>
                            Get.to(() => const ProductReviewScreen()),
                        icon: const Icon(
                          Iconsax.arrow_right_3_copy,
                          size: 18,
                        ))
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSection,
                ),

                const SizedBox(
                  height: TSizes.spaceBtwSection,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
