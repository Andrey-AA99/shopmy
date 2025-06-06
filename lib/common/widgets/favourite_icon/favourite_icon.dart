import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../features/shop/controllers/product/favourites_controller.dart';
import '../../../utils/constants/colors.dart';
import '../icons/t_circular_icon.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon ({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      ()=>
         TCircularIcon(
          icon: controller.isFavourite(productId) ? Iconsax.heart : Iconsax.heart_copy,
          color: controller.isFavourite(productId) ? TColors.error : null,
           onPressed: ()=> controller.toggleFavouriteProduct(productId),
        ),

    );
  }
}
