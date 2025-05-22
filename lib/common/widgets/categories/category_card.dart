import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/controllers/category_controller.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../containers/rounded_container.dart';
import '../images/circular_image.dart';
import '../texts/t_brand_title_with_verified_icon.dart';

class TCategoryCard extends StatelessWidget {
  const TCategoryCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.borderColor,
  });


  final bool showBorder;
  final void Function()? onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        borderColor: borderColor,
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///Icon
            const Flexible(
              child: TCircularImage(
                image: TImages.jacketsCategory,
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            ///Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(
                    title: 'пиджаки',
                    brandTextSize: TextSizes.medium,
                  ),
                  Text(
                    '256 товаров',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
