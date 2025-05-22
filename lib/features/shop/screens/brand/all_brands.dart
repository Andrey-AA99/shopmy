import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/controllers/product/brand_controller.dart';
import 'package:shopmy/features/shop/models/brand_model.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import 'brand_products.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('Бренд'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const TSectionHeading(title: 'Бренды', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Brands
              Obx(
                      () {


                    return TGridLayout(
                        itemCount: brandController.allBrands.length,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {

                          final brand = brandController.allBrands[index];
                          return TBrandCard(
                            showBorder: true,
                            brand: brand,
                            onTap: ()=> Get.to(()=> BrandProducts(brand: brand,)),
                          );
                        });
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}