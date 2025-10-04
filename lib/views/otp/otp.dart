import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets/custom_otp.dart';
import 'otp/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  final OtpController otpController = Get.put(OtpController());
  final TextEditingController otpTextController = TextEditingController();
  final String email;

  OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Enter the 4-digit OTP sent to $email",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Custom Pin Code
            CustomPinCode(controller: otpTextController),

            const SizedBox(height: 30),

            Obx(() => otpController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                otpController.verifyOtp(
                  email,
                  otpTextController.text.trim(),
                );
              },
              child: const Text("Verify OTP"),
            )),
          ],
        ),
      ),
    );
  }
}
