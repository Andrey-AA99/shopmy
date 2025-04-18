import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();



  runApp(const App());
}


