import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignup/core/appRoutes.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  Future<void> sendResetOtp(String email) async {
    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email");
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("https://apitest.softvencefsd.xyz/api/forgot-password"),
        body: {"email": email},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", data["message"] ?? "OTP sent successfully!");
        Get.toNamed(AppRoutes.otp, arguments: {"email": email});
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to send OTP");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
