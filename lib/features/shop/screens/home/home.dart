import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:shopmy/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:shopmy/features/shop/controllers/product/product_controller.dart';
import 'package:shopmy/features/shop/screens/all_products/all_products.dart';
import 'package:shopmy/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shopmy/features/shop/screens/home/widgets/home_categories.dart';

import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
                child: Column(
                  children: [

                    ///AppBar
                    THomeAppBar(),

                    ///Поиск
                    ///TSearchContainer(text: 'Поиск'),
                    SizedBox(height: TSizes.spaceBtwSection),

                    ///Категории
                    Padding(
                      padding: EdgeInsets.only(left: TSizes.defaultSpace),
                      child: Column(
                        children: [

                          ///Title
                          TSectionHeading(
                            title: 'Популярные категории',
                            showActionButton: false,
                            textColor: Colors.white,
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),

                          ///Categories
                          THomeCategories(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSection,
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [

                  ///Заголовок
                  TSectionHeading(title: 'Популярные товары',
                      onPressed: () =>
                          Get.to(() => AllProducts(
                            title: 'Популярные товары', 
                            query:FirebaseFirestore.instance.collection('Products').where('IsFeatured',isEqualTo: true).limit(7),
                            futureMethod: controller.fetchAllFeaturedProducts(),
                          )
                          )
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///Популярные товары
                  Obx(() {
                    if(controller.isLoading.value) return const TVerticalProductShimmer();
                    return TGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) =>
                            TProductCardVertical(product: controller
                                .featuredProducts[index])
                    );
                  })

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
