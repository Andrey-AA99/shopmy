import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/containers/rounded_container.dart';
import 'package:shopmy/common/widgets/texts/product_price_text.dart';
import 'package:shopmy/common/widgets/texts/product_title_text.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/features/shop/controllers/product/variation_controller.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/constants/sizes.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/constants/colors.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());

    return Obx(
        ()=> Column(
        children: [
          /// selected attribute

            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.grey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const TSectionHeading(
                        title: 'Вариант',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TProductTitleText(
                                title: 'Цена : ',
                                smallSize: true,
                              ),

                              if(controller.selectedVariation.value.salePrice > 0)
                              Text(
                                  '${controller.selectedVariation.value.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              TProductPriceText(price: controller.getVariationPrice()),
                            ],
                          ),
                          Row(
                            children: [
                              const TProductTitleText(
                                title: 'Статус : ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///Описание варианта
                  TProductTitleText(
                    title:
                        controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  )
                ],
              ),
            ),
          const SizedBox(height: TSizes.spaceBtwItems),

          ///attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TSectionHeading(
                          title: attribute.name ?? '',
                          showActionButton: false,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        Obx(
                          () => Wrap(
                              spacing: 8,
                              children: attribute.values!.map((attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    attributeValue;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(attributeValue);

                                return TChoiceChip(
                                    text: attributeValue,
                                    selected: isSelected,
                                    onSelected: available
                                        ? (selected) {
                                            if (selected && available) {
                                              controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  attributeValue);
                                            }
                                          }
                                        : null);
                              }).toList()),
                        )
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
