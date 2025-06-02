import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/icons/t_circular_icon.dart';
import 'package:shopmy/common/widgets/layouts/grid_layout.dart';
import 'package:shopmy/common/widgets/loaders/animation_loader.dart';
import 'package:shopmy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shopmy/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:shopmy/features/shop/controllers/product/favourites_controller.dart';
import 'package:shopmy/features/shop/controllers/product/product_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/features/shop/screens/home/home.dart';
import 'package:shopmy/navigation_menu.dart';
import 'package:shopmy/utils/constants/image_strings.dart';
import 'package:shopmy/utils/constants/sizes.dart';
import 'package:shopmy/utils/helpers/cloud_helper_functions.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Избранное',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add_copy,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: controller.favouriteProducts(),
              builder: (context, snapshot) {
                const emptyWidget = Center(
                  child: Text('Пока вы ничего не добавили'),
                );

                const loader = TVerticalProductShimmer(
                  itemCount: 6,
                );
                final widget = TCloudHelperFunction.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget);
                if (widget != null) return widget;

                final products = snapshot.data!;
                return TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) =>
                        TProductCardVertical(product: products[index]));
              }),
        ),
      ),
    );
  }
}
