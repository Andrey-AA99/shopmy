import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/primary_header_container.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           const TPrimaryHeaderContainer(
                child: Column(
              children: [
                ///AppBar
                THomeAppBar(),
                SizedBox(height: TSizes.spaceBtwSection),

                ///Поиск
                TSearchContainer(text: 'Поиск'),
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
                SizedBox(height: TSizes.spaceBtwSection,)
              ],
            )
           ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///Заголовок
                  TSectionHeading(title: 'Популярные товары', onPressed: (){}),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///Популярные товары
                  TGridLayout(itemCount: 4, itemBuilder: (_,index)=> const TProductCardVertical(),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


