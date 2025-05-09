import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";
import "package:shopmy/common/widgets/success_screen/success_screen.dart";
import "package:shopmy/data/repositories/authentication/authentication_repository.dart";
import "package:shopmy/utils/constants/image_strings.dart";
import "package:shopmy/utils/constants/text_strings.dart";
import "package:shopmy/utils/popops/loaders.dart";

class VVerifyEmailController extends GetxController {
  static VVerifyEmailController get instance => Get.find();


  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  ///отправление ссылки
  sendEmailVerification() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: 'Письмо отправлено',message:  'Проверьте свою почту и подтвердите Email');
    }catch(e){
      TLoaders.errorSnackBar(title: 'Что-то пошло не так', message: e.toString());
    }
  }


  ///таймер перехода
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration(
        seconds: 1),
            (timer) async{
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(()=>SuccessScreen(
            image: TImages.successEmail,
            title: TTexts.yourAccountCreatedTitle,
            subTitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(
          ()=>SuccessScreen(
              image: TImages.successEmail,
              title: TTexts.yourAccountCreatedTitle,
              subTitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
          )
      );
    }
  }

}