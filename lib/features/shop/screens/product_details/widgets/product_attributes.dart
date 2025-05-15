import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/containers/rounded_container.dart';
import 'package:shopmy/common/widgets/texts/product_price_text.dart';
import 'package:shopmy/common/widgets/texts/product_title_text.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/utils/constants/sizes.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/constants/colors.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                          Text(
                            '19999',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          const TProductPriceText(price: '14999'),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Статус : ',
                            smallSize: true,
                          ),
                          Text(
                            'В наличии',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    ],
                  ),

                  ///Актуальная цена

                  ///Цена со скидкой
                ],
              ),

              ///Описание варианта
              const TProductTitleText(
                title:
                    'Повседневный однобортный пиджак серого цвета в клетку изготовлен из твила – такой материал обладает приятным блеском и дарит особый комфорт в течение всего дня. Смесовая эластичная ткань приятно тянется в 4 стороны и не сковывает движения, что позволяет чувствовать уверенность в любой ситуации.',
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Цвет',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              children: [
                TChoiceChip(
                  text: 'Grey',
                  selected: true,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'Red',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Размер',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              children: [
                TChoiceChip(
                  text: '48',
                  selected: true,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: '50',
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: '52',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
