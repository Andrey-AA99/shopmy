import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/utils/constants/enums.dart';

import '../../../../common/widgets/list_tiles/payment_tile.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(image: 'Paypal', name: TImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (_)=> SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Выберите способ оплаты',showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwSection,),
            TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: TImages.paypal)),
            const SizedBox(height: TSizes.spaceBtwItems/2,),
            TPaymentTile(paymentMethod: PaymentMethodModel(name: 'MasterCard', image: TImages.paypal)),
            const SizedBox(height: TSizes.spaceBtwItems/2,),
            TPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: TImages.paypal)),
            const SizedBox(height: TSizes.spaceBtwItems/2,),
            TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: TImages.paypal)),
            const SizedBox(height: TSizes.spaceBtwItems/2,),
          ],
        ),
      ),
    ));
  }
}