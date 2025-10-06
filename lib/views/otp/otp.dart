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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter the 6-digit OTP sent to",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Custom Pin Code
            CustomPinCode(controller: otpTextController),

            const SizedBox(height: 30),

            // Verify OTP Button
            Obx(() => otpController.isLoading.value
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (otpTextController.text.trim().length == 6) {
                    otpController.verifyOtp(
                      email,
                      otpTextController.text.trim(),
                    );
                  } else {
                    Get.snackbar(
                      "Invalid OTP",
                      "Please enter a 6-digit OTP",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )),

            const SizedBox(height: 30),

            // Resend OTP Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive the code? ",
                  style: TextStyle(color: Colors.grey),
                ),
                Obx(() {
                  return GestureDetector(
                    onTap: otpController.resendAvailable.value
                        ? () {
                      otpController.resendOtp(email);
                    }
                        : null,
                    child: Text(
                      otpController.resendAvailable.value
                          ? "Resend OTP"
                          : "Resend in ${otpController.timer.value}s",
                      style: TextStyle(
                        color: otpController.resendAvailable.value
                            ? Colors.blue
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}