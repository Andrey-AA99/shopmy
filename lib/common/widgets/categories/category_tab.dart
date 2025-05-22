import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/layouts/grid_layout.dart';
import 'package:shopmy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/features/shop/controllers/category_controller.dart';
import 'package:shopmy/features/shop/models/category_model.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/features/shop/screens/all_products/all_products.dart';
import 'package:shopmy/features/shop/screens/store/widgets/category_brands.dart';

import '../../../features/shop/controllers/product/product_controller.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import 'category_show_case.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ///Бренды
                CategoryBrands(category: category),

                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                ///Товары
                FutureBuilder(
                  future: controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    final products = snapshot.data!;

                    return Column(
                      children: [
                        TSectionHeading(
                          title: 'Вам может понравится',
                          showActionButton: true,
                          onPressed: () => Get.to(AllProducts(title: category.name, futureMethod: controller.getCategoryProducts(categoryId: category.id,limit: -1),)),

                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => TProductCardVertical(product: products[index])),
                        const SizedBox(height: TSizes.spaceBtwSection)
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ]);
  }
}
