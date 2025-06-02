import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/data/repositories/user/address_repository.dart';
import 'package:shopmy/features/personalization/controllers/address_controller.dart';
import 'package:shopmy/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopmy/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.warning,
        child: const Icon(
          Iconsax.add_copy,
          color: TColors.white,
        ),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Адрес', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
              (){
                return FutureBuilder(
                    key: Key(controller.refreshData.value.toString()),
                    future: controller.getAllUserAddresses(),
                    builder: (context, snapshot) {
                      final response = TCloudHelperFunction.checkMultiRecordState(
                          snapshot: snapshot);

                      if (response != null) return response;

                      final addresses = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: addresses.length,
                          itemBuilder: (_, index) =>
                              TSingleAddress( onTap: ()=> controller.selectAddress(addresses[index]), address: addresses[index],));
                    });
              }
          ),
        ),
      ),
    );
  }
}
