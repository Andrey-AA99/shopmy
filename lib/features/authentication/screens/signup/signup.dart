import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Title
                Text(TTexts.signUpTitle,style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: TSizes.spaceBtwSection),
                
                ///Form
                Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextFormField(decoration: const InputDecoration(
                              labelText: TTexts.firstName,
                              prefixIcon: Icon(Iconsax.user)
                              ),
                            ),
                            TextFormField(),
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
        ),
      ),
    );
  }
}
