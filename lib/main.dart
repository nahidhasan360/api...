import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loginsignup/core/appRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences থেকে token লোড করো
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token'); // key একই রাখো everywhere

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(token: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      builder: DevicePreview.appBuilder,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      // ✅ টোকেন থাকলে Home, না থাকলে Login
      initialRoute: token != null ? AppRoutes.home : AppRoutes.login,

      // সব Route এখানে থাকবে
      getPages: AppRoutes.routes,
    );
  }
}
