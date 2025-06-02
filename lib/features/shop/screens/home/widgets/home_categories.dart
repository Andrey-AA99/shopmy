import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/data/repositories/categories/category_repository.dart';
import 'package:shopmy/features/shop/controllers/category_controller.dart';
import 'package:shopmy/features/shop/screens/sub_category/sub_category.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/shimmers/category_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    
    return Obx(() {

      if(categoryController.isLoading.value) return const TCategoryShimmer();

      if(categoryController.featuredCategories.isEmpty){
        return Center(child: Text('Не найдено данных', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
      }
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return TVerticalImageText(
                image:category.image,
                title: category.name,
                onTap: () => Get.to(()=>  SubCategoriesScreen(category: category,)),
              );
            },
          ),
        );
      }
    );
  }
}
