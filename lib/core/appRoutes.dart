import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../views/ForgatePassword/forgate_password.dart';
import '../views/login/login.dart';
import '../views/signup/register.dart';
import '../views/homePage/home_page.dart';
import '../views/otp/otp.dart';

class AppRoutes {
  static const String login = "/LoginPage";
  static const String register = "/Register";
  static const String home = "/HomePage";
  static const String otp = "/OtpScreen";
  static const String forgotPassword = "/ForgotPassword";

  static List<GetPage> routes = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => Register()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(
      name: otp,
      page: () {
        // ✅ এখানে আমরা arguments থেকে email নিচ্ছি
        final args = Get.arguments ?? {};
        final String email = args["email"] ?? "";
        return OtpScreen(email: email);
      },
    ),
    GetPage(name: forgotPassword, page: () => ForgotPasswordPage()),
  ];
}
