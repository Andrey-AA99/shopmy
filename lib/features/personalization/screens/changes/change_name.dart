import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/common/widgets/appbar/appbar.dart';
import 'package:shopmy/common/widgets/images/circular_image.dart';
import 'package:shopmy/utils/constants/sizes.dart';
import 'package:shopmy/utils/validators/validation.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return  Scaffold(
      appBar: TAppBar(showBackArrow: true,title: Text('Смена имени',style: Theme.of(context).textTheme.headlineSmall,)),
      body:  Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Используйте настоящее имя!',style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: TSizes.spaceBtwSection,),


            Form(
              key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) => TValidator.validateEmptyText('Имя', value),
                      expands: false,
                      decoration: const InputDecoration(labelText: TTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) => TValidator.validateEmptyText('Имя', value),
                      expands: false,
                      decoration: const InputDecoration(labelText: TTexts.secondName, prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )
            ),
            const SizedBox(height: TSizes.spaceBtwSection,),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()=>controller.updateUserName(), child: const Text('Сохранить')),
            )
          ],
        ),
      ),
      );
    
  }
}
