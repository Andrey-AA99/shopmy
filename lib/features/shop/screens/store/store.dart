import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/categories/category_tab.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shopmy/common/widgets/layouts/grid_layout.dart';
import 'package:shopmy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shopmy/common/widgets/shimmers/brand_shimmer.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/features/shop/controllers/category_controller.dart';
import 'package:shopmy/features/shop/controllers/brand_controller.dart';
import 'package:shopmy/features/shop/screens/brand/all_brands.dart';
import 'package:shopmy/features/shop/screens/cart/cart.dart';
import 'package:shopmy/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/tapbar.dart';
import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../common/widgets/categories/category_card.dart';
import '../../../../common/widgets/shimmers/brand_shimmer.dart';
import '../../../../utils/constants/colors.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
          appBar: TAppBar(
            title: Text(
              'Магазин',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: const [
              TCartCounterIcon(
                iconColor: TColors.black,

              ),
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: TColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ///Поиск
                          const SizedBox(height: TSizes.spaceBtwItems),
                          /*const TSearchContainer(
                            text: 'Поиск',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),*/
                          const SizedBox(height: TSizes.spaceBtwSection),

                          ///Популярные категории
                          TSectionHeading(
                            title: 'Популярные бренды',
                            onPressed: () => Get.to(()=> const AllBrandsScreen()),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                          Obx(
                              () {
                                if(brandController.isLoading.value) return const TBrandsShimmer();

                                if(brandController.featuredBrands.isEmpty){
                                  return Center(child: Text('Данные не найдены',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.grey),));
                                }

                                return TGridLayout(
                                itemCount: brandController.featuredBrands.length,
                                mainAxisExtent: 80,
                                itemBuilder: (_, index) {

                                  final brand = brandController.featuredBrands[index];
                                  return TBrandCard(
                                    showBorder: true,
                                    brand: brand,
                                  );
                                });
                              }
                          )
                        ],
                      ),
                    ),

                    ///Tabs
                    bottom: TTabBar(
                      tabs: categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList(),
                    ),
                  ),
                ];
              },

              ///body
              body: TabBarView(
                  children: categories
                      .map((category) => TCategoryTab(category: category))
                      .toList())

          )
      ),
    );
  }
}
