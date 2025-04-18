import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';


class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return  Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSection),
        child: Column(
          children: [
            ///email
            TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email,
                )
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///password
            TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash),
                )
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),

            ///Запомнить меня и забыли пароль
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Запомнить меня
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value){},activeColor: TColors.warning,),
                    const Text(TTexts.rememberMe)
                  ],
                ),

                ///Забыли пароль
                TextButton(onPressed: (){}, child: const Text(TTexts.forgetPassword))

              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSection),

            ///Вход кнопка

            SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.warning,

                  ),
                  child: const Text(TTexts.signIn),
                )
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            ///Зарегистрироваться кнопка
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: (){},
                  style: FilledButton.styleFrom(
                    backgroundColor: TColors.warning,
                  ),

                  child: const Text(TTexts.createAccount)
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSection),
          ],
        ),
      ),
    );
  }
}
