import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shopmy/bindings/general_bindings.dart';
import 'package:shopmy/features/authentication/screens/onboarding/onboarding.dart';
import 'package:shopmy/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      ///const Scaffold(backgroundColor: TColors.warning, body: Center(child: CircularProgressIndicator(color: Colors.white,),)
      home: const OnBoardingScreen(),
    );
  }
}
