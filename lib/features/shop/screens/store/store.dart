import 'package:flutter/material.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/categories/category_tab.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shopmy/common/widgets/layouts/grid_layout.dart';
import 'package:shopmy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/tapbar.dart';
import '../../../../common/widgets/categories/category_card.dart';
import '../../../../utils/constants/colors.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: TAppBar(
            title: Text(
              'Магазин',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: [
              TCartCounterIcon(
                onPressed: () {},
                iconColor: TColors.black,
              ),
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: TColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ///Поиск
                          const SizedBox(height: TSizes.spaceBtwItems),
                          const TSearchContainer(
                            text: 'Поиск',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: TSizes.spaceBtwSection),

                          ///Популярные категории
                          TSectionHeading(
                            title: 'Популярные категории',
                            onPressed: () {},
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                          TGridLayout(
                              itemCount: 4,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                return const TCategoryCard(
                                  showBorder: true,
                                  borderColor: TColors.grey,
                                );
                              })
                        ],
                      ),
                    ),

                    ///Tabs
                    bottom: const TTabBar(
                      tabs: [
                        Tab(child: Text('Повседневное')),
                        Tab(child: Text('Формальное')),
                        Tab(child: Text('Спортивное')),
                        Tab(child: Text('Обувь')),
                        Tab(child: Text('Аксессуары')),
                      ],
                    ),
                  ),
                ];
              },

              ///body
              body: const TabBarView(children: [
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
              ]
              )
          )
      ),
    );
  }
}
