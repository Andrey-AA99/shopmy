import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopmy/common/widgets/texts/section_heading.dart';
import 'package:shopmy/data/repositories/user/address_repository.dart';
import 'package:shopmy/features/personalization/models/address_model.dart';
import 'package:shopmy/features/personalization/screens/address/add_new_address.dart';
import 'package:shopmy/features/personalization/screens/address/widgets/single_address.dart';
import 'package:shopmy/utils/constants/enums.dart';
import 'package:shopmy/utils/constants/image_strings.dart';
import 'package:shopmy/utils/helpers/cloud_helper_functions.dart';
import 'package:shopmy/utils/helpers/network_manager.dart';
import 'package:shopmy/utils/popops/full_screen_loader.dart';
import 'package:shopmy/utils/popops/loaders.dart';

import '../../../utils/constants/sizes.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = AddressRepository.instance;

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere((e) => e.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Адрес не найден', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CircularProgressIndicator());

      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Ошибка выбора', message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Сохраняем адрес', TImages.loadAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          country: country.text.trim(),
          postalCode: postalCode.text.trim(),
          selectedAddress: true);

      final id = await addressRepository.addAddress(address);

      address.id = id;
      await selectAddress(address);

      TLoaders.successSnackBar(
          title: 'Адрес добавлен', message: 'Ваш адрес успешно сохранен');

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Адрес не найден', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(TSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TSectionHeading(title: 'Выберите адрес'),
                  FutureBuilder(
                      future: getAllUserAddresses(),
                      builder: (_, snapshot) {
                        final response =
                            TCloudHelperFunction.checkMultiRecordState(
                                snapshot: snapshot);
                        if (response != null) return response;

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => TSingleAddress(
                              address: snapshot.data![index],
                              onTap: ()async {
                                await selectAddress(snapshot.data![index]);
                                Get.back();
                              },
                            ));
                      }),
                  const SizedBox(height: TSizes.defaultSpace *2,),
                  SizedBox(width: double.infinity,child: ElevatedButton(onPressed:()=> Get.to(()=> const AddNewAddressScreen()), child: const Text('Добавить новый адрес')),)
                ],
              ),
            ));
  }
}
