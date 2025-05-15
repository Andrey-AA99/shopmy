import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/layouts/grid_layout.dart';
import 'package:shopmy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import 'category_show_case.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children:[
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Categories
              const TCategoriesShowCase(images: [TImages.jacket_casual_1,TImages.jacket_casual_2,TImages.jacket_casual_3],),
              const TCategoriesShowCase(images: [TImages.jacket_casual_1,TImages.jacket_casual_2,TImages.jacket_casual_3],),
              const SizedBox(height: TSizes.spaceBtwItems,),

              ///Товары
              TSectionHeading(title: 'Вам может понравится',showActionButton: true,onPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwItems,),

              TGridLayout(itemCount: 4, itemBuilder: (_,index) => const TProductCardVertical()),
              const SizedBox(height: TSizes.spaceBtwSection)
            ],
          ),
        ),
      ]
    );
  }
}
