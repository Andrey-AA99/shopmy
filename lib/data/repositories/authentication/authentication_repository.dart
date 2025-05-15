import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopmy/features/authentication/screens/login/login.dart';
import 'package:shopmy/features/authentication/screens/onboarding/onboarding.dart';
import 'package:shopmy/features/authentication/screens/signup/verify_email.dart';
import 'package:shopmy/navigation_menu.dart';
import 'package:shopmy/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:shopmy/utils/exceptions/firebase_exceptions.dart';
import 'package:shopmy/utils/exceptions/format_exceptions.dart';
import 'package:shopmy/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();


  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;


  //Get Aethenticated User Data
  User? get authUser => _auth.currentUser;


  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
  if(user != null){
    if(user.emailVerified){
      Get.offAll(()=> const NavigationMenu());
    } else{
      Get.offAll(()=> VerifyEmailScreen(email: _auth.currentUser?.email,));
    }
  }else{
    deviceStorage.writeIfNull('IsFirstTime', true);

    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(()=> const LoginScreen())
        : Get.offAll(const OnBoardingScreen());
    }
  }

  ///email authentication signin
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on  FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch (e){
      throw 'Что-то пошло не так. Попробуйте позже';
    }
  }
 ///email authentication register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on  FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch (e){
      throw 'Что-то пошло не так. Попробуйте позже';
    }
  }
  ///email verification
 Future<void> sendEmailVerification() async {
    try{
      await _auth.currentUser?.sendEmailVerification();
    }on  FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch (e){
      throw 'Что-то пошло не так. Попробуйте позже';
    }
 }
  ///google sign in
  Future<UserCredential?> signInWithGoogle() async {
    try{
      // Triger the authentification flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //create a new
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );

      // return User Credential
      return await _auth.signInWithCredential(credentials);

    }on  FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch (e){
      if(kDebugMode) print('Что-то пошло не так. $e');
      return null;
    }
  }


 ///logout
  Future<void> logout() async {
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(()=> const LoginScreen());
    }on  FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    }on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch (e){
      throw 'Что-то пошло не так. Попробуйте позже';
    }
  }





}