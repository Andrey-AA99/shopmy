import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:shopmy/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';
import 'package:shopmy/utils/constants/colors.dart';
import 'package:shopmy/utils/constants/sizes.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerAuth = AuthenticationRepository.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                      title: Text('Аккаунт',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: TColors.white))),

                  TUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSection),

                  ///User Profile Card
                ],
              ),
            ),

            ///Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(
                      title: 'Настройки аккаунта', showActionButton: false),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home_copy,
                    title: 'Мой адрес',
                    subTitle: 'Установить адрес доставки',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart_copy,
                    title: 'Моя корзина',
                    subTitle: 'Добавление и удаление товаров, переход к оплате',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick_copy,
                    title: 'Мои заказы',
                    subTitle: 'Созданные заказы и выполненные',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.discount_shape_copy,
                    title: 'Мои промокоды',
                    subTitle: 'Список скидок',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification_copy,
                    title: 'Уведомления',
                    subTitle: 'Установить уведомления',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_card_copy,
                    title: 'Безопасность',
                    subTitle: 'Управление данными пользователя',
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSection,
                  ),
                  const TSectionHeading(
                    title: 'Настройки приложения',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload_copy,
                    title: 'Загрузить данные',
                    subTitle: 'Загрузите данные в FireBase Cloud',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Геолокация',
                    subTitle: 'Разрешите доступ к геолокации',
                    onTap: () {},
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSection),
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: controllerAuth.logout,
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: TColors.warning),
                              foregroundColor: TColors.darkerGrey),
                          child: const Text('Выход'))),
                  const SizedBox(
                    height: TSizes.spaceBtwSection * 2.5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
