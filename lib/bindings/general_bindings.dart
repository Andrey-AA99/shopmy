import 'package:get/get.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';
import 'package:shopmy/data/repositories/user/user_repository.dart';
import 'package:shopmy/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}