import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/login_signup/form_divider.dart';
import 'package:shopmy/common/widgets/login_signup/social_buttons.dart';
import 'package:shopmy/features/authentication/screens/login/widgets/login_form.dart';
import 'package:shopmy/features/authentication/screens/login/widgets/login_header.dart';
import 'package:shopmy/utils/constants/text_strings.dart';
import 'package:shopmy/utils/helpers/helper_functions.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            ///login header
            const TLoginHeader(),

            ///Login form
            const TLoginForm(),

            TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
            const SizedBox(height: TSizes.spaceBtwSection),

            ///Footer
            const TSocialButtons()
          ],
        ),
      )),
    );
  }
}
