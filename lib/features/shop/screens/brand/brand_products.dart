import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:shopmy/features/shop/controllers/brand_controller.dart';
import 'package:shopmy/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              TBrandCard(showBorder: true,brand: brand,),
              const SizedBox(height: TSizes.spaceBtwSection),

              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  const loader = TVerticalProductShimmer();
                  final widget = TCloudHelperFunction.checkMultiRecordState(snapshot: snapshot,loader: loader);
                  if(widget != null) return widget;

                  final brandProducts = snapshot.data!;
                  return TSortableProducts(products: brandProducts,);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}