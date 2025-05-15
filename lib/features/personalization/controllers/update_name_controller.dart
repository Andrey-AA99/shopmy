import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopmy/data/repositories/user/user_repository.dart';
import 'package:shopmy/features/personalization/controllers/user_controller.dart';
import 'package:shopmy/features/personalization/screens/profile/profile.dart';
import 'package:shopmy/utils/helpers/network_manager.dart';
import 'package:shopmy/utils/popops/full_screen_loader.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/popops/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Мы обновляем информацию', TImages.loadAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      TLoaders.successSnackBar(
          title: 'Обновлено', message: 'Ваше имя обновилось');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Ой ошибка', message: e.toString());
    }
  }
}
