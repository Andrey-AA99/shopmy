import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/shop/screens/store/store.dart';
import 'package:shopmy/utils/constants/colors.dart';

import 'features/shop/screens/home/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index)=> controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home),label: 'Главная'),
              NavigationDestination(icon: Icon(Iconsax.shop),label: 'Магазин'),
              NavigationDestination(icon: Icon(Iconsax.heart),label: 'Избранное'),
              NavigationDestination(icon: Icon(Iconsax.user),label: 'Профиль'),
          ],
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Obx(()=>controller.screens[controller.selectedIndex.value])
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeScreen(),const StoreScreen(),Container(color: Colors.orange),Container(color: Colors.blue)];
}