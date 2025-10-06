import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loginsignup/core/appRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;
  var resendAvailable = true.obs;
  var timer = 0.obs;

  Timer? _resendTimer; // Store timer reference to cancel it properly

  @override
  void onClose() {
    _resendTimer?.cancel(); // Clean up timer when controller is disposed
    super.onClose();
  }

  // Function to start the resend timer
  void startResendTimer() {
    resendAvailable.value = false;
    timer.value = 50;

    _resendTimer?.cancel(); // Cancel any existing timer

    _resendTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (timer.value > 0) {
        timer.value--;
      } else {
        resendAvailable.value = true;
        t.cancel();
      }
    });
  }

  // Save token to SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
    print("✅ Token Saved: $token");
  }

  // API to verify OTP
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
          Get.snackbar("Success", data["message"] ?? "OTP Verified");

          // Save token if exists
          String? token = data["token"];
          if (token != null) {
            await saveToken(token);
          }

          Get.toNamed(AppRoutes.home);
        } else {
          Get.snackbar("Error", data["message"] ?? "Invalid OTP");
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

  // API to resend OTP
  Future<void> resendOtp(String email) async {
    if (!resendAvailable.value) return;

    startResendTimer(); // Start timer immediately when button is clicked

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("https://apitest.softvencefsd.xyz/api/resend_otp"),
        headers: {"Accept": "application/json"},
        body: {"email": email},
      );

      final data = jsonDecode(response.body);
      print("📨 Resend OTP Response: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ OTP resent successfully");
        Get.snackbar("Success", data["message"] ?? "OTP resent successfully!");
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to resend OTP");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}