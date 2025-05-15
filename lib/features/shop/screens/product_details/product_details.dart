import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/icons/t_circular_icon.dart';
import 'package:shopmy/common/widgets/images/rounded_image.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
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
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(children: [
          ///Слайдер
          const TProductImageSlider(),

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
                const TProductMetaData(),

                ///Атрибуты
                const TProductAttributes(),
                const SizedBox(
                  height: TSizes.spaceBtwSection,
                ),

                ///
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Смотреть'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.warning,
                          shadowColor: TColors.warning),
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
                const ReadMoreText(
                  'Повседневный однобортный пиджак HENDERSON в клетку изготовлен из твила – такой материал обладает приятным блеском и дарит особый комфорт в течение всего дня. Смесовая эластичная ткань приятно тянется в 4 стороны и не сковывает движения, что позволяет чувствовать уверенность в любой ситуации.Модель с прямыми лацканами дополнена двумя накладными карманами на талии и имеет двойную шлицу, изделие не будет заминаться, когда вы садитесь. Пиджак в прямом силуэте подойдет на мужчину среднего телосложения.Такое изделие хорошо дополнит мужской гардероб – рекомендуем выбрать к нему рубашку, поло или футболку, брюки-чинос, классические со стрелками или джинсы.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Делее',
                  trimExpandedText: 'Свернуть',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  lessStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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
