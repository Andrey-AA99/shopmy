import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/features/personalization/controllers/address_controller.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Адрес доставки',
          buttonTitle: 'Сменить',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        addressController.selectedAddress.value.id.isNotEmpty ? 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(()=> Text(addressController.selectedAddress.value.name, style: Theme.of(context).textTheme.bodyLarge)),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16),
                const SizedBox(width: TSizes.spaceBtwItems),
                Obx(
                ()=> Text(
                    addressController.selectedAddress.value.phoneNumber,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.location_history, color: Colors.grey, size: 16),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: Obx(
    ()=> Text(
                      addressController.selectedAddress.value.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ) : Text('Выберите адрес', style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}