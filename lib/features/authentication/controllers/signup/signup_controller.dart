import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';
import 'package:shopmy/data/repositories/user/user_repository.dart';
import 'package:shopmy/features/authentication/screens/signup/verify_email.dart';
import 'package:shopmy/utils/popops/loaders.dart';
import 'package:shopmy/utils/constants/image_strings.dart';
import 'package:shopmy/utils/helpers/network_manager.dart';
import 'package:shopmy/utils/popops/full_screen_loader.dart';

import '../../../personalization/models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///переменные
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      //start Loading
      TFullScreenLoader.openLoadingDialog(
          'Мы загружаем вашу информацию...', TImages.loadAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Примите условия политики конфиденциальности',
            message:
                'Для создания акканута вам необходимио прочитать и принять условия политики конфиденциальности.');
        return;
      }
      //Register user in the firebase authentication & save data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      //save authenticated user data in the firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //show success message
      TLoaders.successSnackBar(
          title: "Поздравляем",
          message: "Ваш аккаунт создан! Осталось подтвердить Email");

      // move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
