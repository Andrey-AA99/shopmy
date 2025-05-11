import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shopmy/features/authentication/controllers/login/login_controller.dart';
import 'package:shopmy/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:shopmy/features/authentication/screens/signup/signup.dart';
import 'package:shopmy/navigation_menu.dart';
import 'package:shopmy/utils/validators/validation.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSection),
        child: Column(
          children: [
            ///email
            TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email,
                )),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            ///Запомнить меня и забыли пароль
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Запомнить меня
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                        activeColor: TColors.warning,
                      ),
                    ),
                    const Text(TTexts.rememberMe)
                  ],
                ),

                ///Забыли пароль
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(TTexts.forgetPassword))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSection),

            ///Вход кнопка

            SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.warning,
                  ),
                  child: const Text(TTexts.signIn),
                )),
            const SizedBox(height: TSizes.spaceBtwItems),

            ///Зарегистрироваться кнопка
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  style: FilledButton.styleFrom(
                    backgroundColor: TColors.warning,
                  ),
                  child: const Text(TTexts.createAccount)),
            ),
            const SizedBox(height: TSizes.spaceBtwSection),
          ],
        ),
      ),
    );
  }
}
