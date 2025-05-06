import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:shopmy/utils/constants/sizes.dart';
import 'package:shopmy/utils/constants/text_strings.dart';

import '../../../../utils/constants/colors.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordTitleSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSection*2),


            ///Text field email
            TextFormField(
              decoration:const  InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),

              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSection),

            ///Подтверждение
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: ()=>Get.off(()=> const ResetPassword()),
                  style: FilledButton.styleFrom(
                    backgroundColor: TColors.warning,
                  ),
                  child: const Text(TTexts.submit),
              ),

            )



          ],
        ),
      ),
    );
  }
}
