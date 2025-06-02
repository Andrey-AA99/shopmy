import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/shop/controllers/product/cart_controller.dart';
import 'package:shopmy/utils/helpers/pricing_calculator.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {

    final cartController = Get.put(CartController());
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        /// Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Всего', style: Theme.of(context).textTheme.bodyMedium),
            Text('$subTotal р.', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Цена доставки', style: Theme.of(context).textTheme.bodyMedium),
            Text('${TPricingCalculator.calculateShippingCost(subTotal, 'РФ')} р.', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),


        /// Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Итого', style: Theme.of(context).textTheme.bodyMedium),
            Text('${TPricingCalculator.calculateTotalPrice(subTotal, 'РФ')}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}