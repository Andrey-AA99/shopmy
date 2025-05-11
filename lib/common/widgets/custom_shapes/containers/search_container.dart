import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key, required this.text, this.icon = Iconsax.search_normal_copy, this.showBackground = true, this.showBorder = true,
  });


  final String text;
  final IconData? icon;
  final bool showBackground,showBorder;

  @override
  Widget build(BuildContext context) {



    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
            color:  Colors.white,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: TColors.grey) : null
        ),
        child: Row(
          children: [
            Icon(icon,color: TColors.darkerGrey,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text(text,style: Theme.of(context).textTheme.bodySmall,),
          ],
        ),

      ),
    );
  }
}