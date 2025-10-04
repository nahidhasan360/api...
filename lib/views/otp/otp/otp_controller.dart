import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignup/core/appRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;



  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
     print("✅ Token Saved: $token");

  }


  // API
  Future<void> verifyOtp(String email, String otp) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("https://apitest.softvencefsd.xyz/api/verify_otp"),
        headers: {"Accept": "application/json"},
        body: {"email": email, "otp": otp},
      );


    if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);



        if (data["status"] == true) {
          // ✅ Token Extract
          Get.snackbar("Success", data["message"] ?? "OTP Verified ");
          Get.toNamed(AppRoutes.home);

          // token save
          String? token = data["token"];

          if (token != null) {
            await saveToken(token);
          }


        } else {
          Get.snackbar("Error", data["message"] ?? "Invalid OTP ");
        }
      } else {
        Get.snackbar("Error", "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
