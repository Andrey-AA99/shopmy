import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  ///widget Binding
  WidgetsFlutterBinding.ensureInitialized();

  ///local storage
  await GetStorage.init();

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  runApp(const App());
}
