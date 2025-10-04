import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../homePage/home_page.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  // 🔹 Login function
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    final url = Uri.parse("https://apitest.softvencefsd.xyz/api/login");

    try {
      final response = await http.post(
        url,
        body: {
          "email": email,
          "password": password,
        },
      );

      final data = jsonDecode(response.body);
      print("🔍 Login response: $data");

      if (response.statusCode == 200 && data["status"] == true) {
        final token = data["token"] ?? data["access_token"];

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_token', token);
          print("✅ Token saved: $token");
        } else {
          print("⚠️ Token not found in response");
        }

        Get.snackbar("Success", "Login successful!");

        // 🏠 Home Page এ যাও
        Get.offAll(() => HomePage());
      } else {
        Get.snackbar("Error", data["message"] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
