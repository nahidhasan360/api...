import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/homePage/home_page.dart';
import '../views/login/login.dart';
import '../views/signup/register.dart';

class AppRoutes {

  static const String LoginA ="/LoginPage";
  static const String register ="/Register";
  static const String home ="/HomePage";

  static List<GetPage> routes = [

    GetPage(name: LoginA, page: () => LoginPage()),
    GetPage(name: register, page: () => Register()),
    GetPage(name: home, page: () => HomePage()),


  ];





}