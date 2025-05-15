import 'package:get/get.dart';
import 'package:shopmy/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopmy/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ForgetPasswordController());
  }
}
