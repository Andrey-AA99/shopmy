import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/controllers/category_controller.dart';
import 'package:shopmy/features/shop/models/category_model.dart';
import 'package:shopmy/features/shop/screens/all_products/all_products.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const TRoundedImage(
                imageUrl: TImages.jacket_casual_1_3,
                applyImageRadius: true,
                width: double.infinity,
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              /// Sub-Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    final subCategories = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];
                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                final products = snapshot.data!;
                                return Column(
                                  children: [
                                    /// Heading
                                    const SizedBox(
                                        height: TSizes.spaceBtwItems / 2),
                                    TSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(
                                        () => AllProducts(
                                          title: subCategory.name,
                                          futureMethod:
                                              controller.getCategoryProducts(
                                                  categoryId: subCategory.id,
                                                  limit: -1),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                                width: TSizes.spaceBtwItems),
                                        itemBuilder: (context, index) =>
                                            TProductCardHorizontal(
                                                product: products[index]),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
