import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:shopmy/features/shop/controllers/brand_controller.dart';
import 'package:shopmy/features/shop/models/category_model.dart';
import 'package:shopmy/utils/constants/enums.dart';
import 'package:shopmy/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/categories/category_show_case.dart';
import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {


          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(height: TSizes.spaceBtwItems),
              TBoxesShimmer(),
              SizedBox(height: TSizes.spaceBtwItems),
            ],
          );
          final widget = TCloudHelperFunction.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;


          final brands = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {

              final brand = brands[index];
              return FutureBuilder(future: controller.getBrandProducts(
                  brandId: brand.id, limit: 3), builder: (context, snapshot) {

                final widget = TCloudHelperFunction.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) return widget;
                
                final products = snapshot.data!;

                return TBrandShowCase(brand: brand, images: products.map((e)=>e.thumbNail).toList());
              }
              );
            },
        );
        }
    );
  }
}


