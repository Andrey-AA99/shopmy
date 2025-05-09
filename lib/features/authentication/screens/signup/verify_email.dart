import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/success_screen/success_screen.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';
import 'package:shopmy/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:shopmy/features/authentication/screens/login/login.dart';
import 'package:shopmy/utils/constants/colors.dart';
import 'package:shopmy/utils/constants/image_strings.dart';


import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key,this.email});

  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = (VVerifyEmailController());

    return Scaffold(


      appBar: AppBar(
        actions: [
          IconButton(onPressed:() => AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              
              ///Image
              const Image(
                  image: AssetImage(TImages.signUp)
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              ///Title & SubTitle
              Text(
                  TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                  email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                  TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              ///Buttons
              SizedBox(
                width: double.infinity,
                child:
                  FilledButton(
                      onPressed:()=> controller.checkEmailVerificationStatus(),
                      style: FilledButton.styleFrom(
                          backgroundColor: TColors.warning,

                  ),
                      child:
                      const Text(TTexts.tContinue),
                )
              ),

              SizedBox(width: double.infinity, child: TextButton(onPressed: ()=>controller.sendEmailVerification(), child: const Text(TTexts.resendEmail)),)

            ],
          ),
        ),
      ),
    );
  }
}
    