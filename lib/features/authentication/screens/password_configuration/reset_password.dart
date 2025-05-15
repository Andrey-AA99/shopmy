import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/utils/constants/colors.dart';
import 'package:shopmy/utils/constants/sizes.dart';
import 'package:shopmy/utils/constants/text_strings.dart';

import '../../../../utils/constants/image_strings.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=> Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const Image(
                  image: AssetImage(TImages.signUp)
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              ///Title & SubTitle
              Text(
                  TTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                  TTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: TSizes.spaceBtwSection),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child:
                  FilledButton(
                    onPressed:(){},
                    style: FilledButton.styleFrom(
                      backgroundColor: TColors.warning,

                    ),
                    child:
                    const Text(TTexts.submit),
                  )
              ),

              SizedBox(width: double.infinity, child: TextButton(onPressed: (){}, child: const Text(TTexts.resendEmail)),)


            ],
          ),
        ),
      ),
    );
  }
}
