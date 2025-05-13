import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/containers/rounded_container.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shopmy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/utils/constants/sizes.dart';

import '../../../../common/widgets/images/circular_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppBar(
          title: Text(
            'Магазин',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
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
                        const TSearchContainer(
                          text: 'Поиск',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSection),

                        ///Популярные категории
                        TSectionHeading(
                          title: 'Популярные категории',
                          onPressed: () {},
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                        const TRoundedContainer(
                          padding: EdgeInsets.all(TSizes.sm),
                          borderColor: TColors.grey,
                          showBorder: true,
                          backgroundColor: Colors.transparent,
                          child: Row(
                            children: [
                              TCircularImage(image: TImages.jacketsCategory, isNetworkImage: false,backgroundColor: Colors.transparent,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Container()));
  }
}


