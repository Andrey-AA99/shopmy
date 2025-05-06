import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopmy/utils/constants/image_strings.dart';
import 'package:shopmy/utils/popops/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();


  ///переменные
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();





  Future<void> signup() async {
    try {
      //start Loading
      TFullScreenLoader.openLoadingDialog('Мы загружаем вашу информацию...', TImages.loadAnimation);
      // Check Internet Connectivity

      //Form Validation

      //Privacy Policy Check

      //Register user in the firebase authentication & save data in the firebase

      //save authenticated user data in the firebase firestore

      //show success message

      // move to verify email screen

    }catch(e){

    }finally{

    }

  }
}