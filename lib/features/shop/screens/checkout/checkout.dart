import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shopmy/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:shopmy/features/shop/screens/checkout/widgets/billing_payment_section.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Проверка заказа',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Items in Cart
              TCartItems(showAddRemoveButton: false),
              SizedBox(height: TSizes.spaceBtwSection),

              /// -- Coupon TextField
              TCouponCode(),
              SizedBox(height: TSizes.spaceBtwSection),

              /// -- Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Address
                    TBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(
                () => SuccessScreen(
              image: TImages.successfulPaymentIcon,
              title: 'Оплата прошла!',
              subTitle: 'Ваш товар уже в пути!',
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            ),
          ),
          child: const Text('Итого 29998 р.'),
        ),
      ),
    );
  }
}
