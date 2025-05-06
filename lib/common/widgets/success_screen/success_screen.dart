import 'package:flutter/material.dart';
import 'package:shopmy/common/styles/spacing_styles.dart';
import 'package:shopmy/utils/constants/colors.dart';
import 'package:shopmy/utils/constants/sizes.dart';
import 'package:shopmy/utils/constants/text_strings.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title,subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight*2,
            child: Column(
              children: [
                Image(
                    image: AssetImage(image)
                ),
                const SizedBox(height: TSizes.spaceBtwSection),

                ///Title & SubTitle
                Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                    subTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center
                ),
                const SizedBox(height: TSizes.spaceBtwSection),

                ///Buttons
                SizedBox(
                    width: double.infinity,
                    child:
                    FilledButton(
                      onPressed: onPressed,
                      style: FilledButton.styleFrom(
                        backgroundColor: TColors.warning,

                      ),
                      child:
                      const Text(TTexts.tContinue),
                    )
                ),
              ],
            ),

        ),
      ),
    );
  }
}
