import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/texts/t_brand_title_with_verified_icon.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/rounded_image.dart';
import '../../texts/product_title_text.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: TImages.jacket_casual_1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price, & Size
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBrandTitleWithVerifiedIcon(title: 'Пиджак'),
            const Flexible(
              child: TProductTitleText(
                title: 'Повседневный пиджак',
                maxLines: 1,
              ),
            ),

            /// Attributes
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Цвет: ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: 'Серый ',
                      style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(
                      text: 'Размер: ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: '48 ',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
