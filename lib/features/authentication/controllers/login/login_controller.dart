import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';
import 'package:shopmy/features/personalization/controllers/user_controller.dart';
import 'package:shopmy/utils/constants/image_strings.dart';
import 'package:shopmy/utils/helpers/network_manager.dart';
import 'package:shopmy/utils/popops/full_screen_loader.dart';
import 'package:shopmy/utils/popops/loaders.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  /*@override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL');
    password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }*/

  ///Email and password signIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      ///start loading
      TFullScreenLoader.openLoadingDialog(
          'Подключаемся...', TImages.loadAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Что-то пошло не так', message: e.toString());
    }
  }

  ///Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Подключаемся', TImages.loadAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      ///Google Auth
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      /// Save user record
      await userController.saveUserRecord(userCredentials);

      ///remove loading
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Ой ошибка', message: e.toString());
    }
  }
}
