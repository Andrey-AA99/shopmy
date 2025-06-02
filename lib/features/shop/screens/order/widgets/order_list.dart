import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/common/widgets/loaders/animation_loader.dart';
import 'package:shopmy/features/shop/controllers/product/order_controller.dart';
import 'package:shopmy/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);

    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          const emptyWidget = TAnimationLoaderWidget(
              text: 'Нет заказов', animation: TImages.addToCartAnimation);

          final response = TCloudHelperFunction.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          final orders = snapshot.data!;
          return ListView.separated(
            shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (_, index) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final order = orders[index];
              return TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// -- Row 1
                    Row(
                      children: [
                        /// 1 - Icon
                        const Icon(Iconsax.ship_copy),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),

                        /// 2 - Status & Date
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderStatus,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                        color: TColors.warning,
                                        fontWeightDelta: 1),
                              ),
                              Text(order.formattedOrderDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ],
                          ),
                        ),

                        /// 3 - Icon
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_1_copy,
                            size: TSizes.iconSm,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// -- Row 2
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              /// 1 - Icon
                              const Icon(Iconsax.tag_copy),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),

                              /// 2 - Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Заказ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text(order.id,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              /// 1 - Icon
                              const Icon(Iconsax.calendar_1_copy),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),

                              /// 2 - Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Дата доставки',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text(order.formatedDeliveryDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
