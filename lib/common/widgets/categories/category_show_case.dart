import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../containers/rounded_container.dart';
import 'category_card.dart';

class TCategoriesShowCase extends StatelessWidget {
  const TCategoriesShowCase({
    super.key, required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          ///Категория и число товаров
          const TCategoryCard(showBorder: false,borderColor: Colors.transparent,),

          ///Топ три товара категории
          Row(
            children: images.map((image)=>categoryTopProductImageWidget(image, context)).toList(),
          )

        ],
      ),
    );
  }


  Widget categoryTopProductImageWidget(String image,context){
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        child: Image(image: AssetImage(image),fit: BoxFit.contain,),
      ),
    );
  }
}