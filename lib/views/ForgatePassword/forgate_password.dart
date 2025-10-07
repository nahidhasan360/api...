import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your registered email to receive an OTP for password reset.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String email = emailController.text.trim();

                  if (email.isEmpty) {
                    Get.snackbar("Error", "Please enter your email");
                  } else {
                    // 🔹 এখানে তুমি তোমার resendOtp বা forgotPassword API call করবে
                    print("📩 Sending password reset OTP to $email");

                    // OTP পেজে পাঠানো (তুমি চাইলে আলাদা forgot OTP পেজ বানাতে পারো)
                    Get.toNamed("/OtpScreen", arguments: {"email": email});
                  }
                },
                child: const Text("Send OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
