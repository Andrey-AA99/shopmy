import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/authentication/controllers/signup/signup_controller.dart';
import 'package:shopmy/features/authentication/screens/signup/verify_email.dart';
import 'package:shopmy/utils/constants/text_strings.dart';
import 'package:shopmy/utils/helpers/helper_functions.dart';
import 'package:shopmy/utils/validators/validation.dart';

import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value)=> TValidator.validateEmptyText('Имя', value),
                    expands:false,
                    decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputFields,),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value)=> TValidator.validateEmptyText('Фамилия', value),
                    expands:false,
                    decoration: const InputDecoration(
                        labelText: TTexts.secondName,
                        prefixIcon: Icon(Iconsax.user)
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),

            ///username
            TextFormField(
              controller: controller.userName,
              validator: (value)=> TValidator.validateEmptyText('Логин', value),
              expands:false,
              decoration: const InputDecoration(
                  labelText: TTexts.userName,
                  prefixIcon: Icon(Iconsax.user_edit)
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields,),

            ///email
            TextFormField(
              controller: controller.email,
              validator: (value)=> TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct)
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields,),

            ///phone
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value)=> TValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: TTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call)
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields,),


            ///password
            Obx(
              ()=> TextFormField(
                controller: controller.password,
                validator: (value)=> TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields,),


            /// PrivacyPolicy
            Row(
              children: [
                SizedBox(
                    width: 24,
                    height: 24,
                    child:
                    Obx(()=> Checkbox(
                      value: controller.privacyPolicy.value,
                      onChanged: (value)=>controller.privacyPolicy.value = !controller.privacyPolicy.value
                      ),
                    ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text: '${TTexts.iAgreeTo} ',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: TTexts.privatePolicy,
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: dark ? TColors.white : TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: dark ? TColors.white : TColors.primary,
                          ))

                    ]
                ))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSection,),


            SizedBox(width: double.infinity,child: FilledButton(onPressed: controller.signup,style: FilledButton.styleFrom(
              backgroundColor: TColors.warning,
            ), child: const Text(TTexts.createAccount),
            ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields,),


            ///SignUp
            TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),

            const SizedBox(height: TSizes.spaceBtwInputFields,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      onPressed: (){},
                      icon: const Image(
                          width: TSizes.iconMd,
                          height: TSizes.iconMd,
                          image: AssetImage(TImages.google))
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: TColors.grey), borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      onPressed: (){},
                      icon: const Image(
                          width: TSizes.iconLg,
                          height: TSizes.iconLg,
                          image: AssetImage(TImages.vk))
                  ),
                ),
              ],
            ),

          ],
        )
    );
  }
}
