import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/shop/controllers/product/images_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key, required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius),
                child: Center(
                  child: Obx((){
                    final image = controller.selectedProductImage.value;
                    return  GestureDetector(
                      onTap: ()=> controller.showEnlargedImage(image),
                      child: CachedNetworkImage(imageUrl: image,
                      progressIndicatorBuilder: (_,__,downloadProgress)=>CircularProgressIndicator(value: downloadProgress.progress, color: TColors.warning,),),
                    );
                  }),
                ),
              ),
            ),

            ///Image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemBuilder: (_, index) => Obx(
                    (){
                      final imageSelected = controller.selectedProductImage.value == images[index];
                      return TRoundedImage(
                      width: 80,
                      onPressed: ()=>controller.selectedProductImage.value = images[index],
                      isNetworkImage: true,
                      backgroundColor: TColors.white,
                      imageUrl: images[index],
                      border: Border.all(color: imageSelected ? TColors.warning : Colors.transparent),
                      padding: const EdgeInsets.all(TSizes.sm),
                    );}
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),

            const TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(
                  icon: Iconsax.heart,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
