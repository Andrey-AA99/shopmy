import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:shopmy/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shopmy/utils/constants/enums.dart';
import 'package:shopmy/utils/constants/text_strings.dart';
import 'package:shopmy/utils/device/device_utility.dart';

import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                ///AppBar
                THomeAppBar(),
                SizedBox(height: TSizes.spaceBtwSection),

                ///Поиск
                TSearchContainer(text: 'Поиск'),
                SizedBox(height: TSizes.spaceBtwSection),

                ///Категории
                Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [],
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
