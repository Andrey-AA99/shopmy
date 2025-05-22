import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/controllers/product/all_products_controller.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.title, this.query, required this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>> futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());


    return Scaffold(
      appBar:
      TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                final products = snapshot.data!;

                return TSortableProducts(products: products,);
              }
            ),
          ),
        ),
      ),
    );
  }
}