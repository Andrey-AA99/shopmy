import 'package:flutter/material.dart';
import 'package:shopmy/features/shop/controllers/product/brand_controller.dart';
import 'package:shopmy/features/shop/models/category_model.dart';

import '../../../../../common/widgets/categories/category_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          final brands = snapshot.data!;

          return ListView.builder(
            itemBuilder: (_,index){
              final brand = brands[index];
              return FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id,limit: 3),
                builder: (context, snapshot) {

                  final products = snapshot.data!;
                  return TBrandShowCase(
                    brand: brand,
                    images:products.map((e)=> e.thumbNail).toList(),

                  );
                }
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,);


        }
    );
  }
}
