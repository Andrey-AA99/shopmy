import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/shop/controllers/product/all_products_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);

    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          items: [
            'По названию',
            'По возрастанию цены',
            'По убыванию цены',
            'Скидка',
            'По новизне',
            'По популярности'
          ]
              .map((option) =>
              DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {

            controller.sortProducts(value!);
          },
          decoration:
          const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        ),
        const SizedBox(height: TSizes.spaceBtwSection),

        /// Products
        Obx(
          ()=> TGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>  TProductCardVertical(product: controller.products[index],),
          ),
        ),
      ],
    );
  }
}