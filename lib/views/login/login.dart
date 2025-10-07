// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/appRoutes.dart';
import '../../utils/app_colors.dart';
import '../signup/register.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Controller initialize
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 40),

              // Login Button
              Obx(() {
                return GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : () {
                          controller.loginUser(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Register button



              GestureDetector(
                onTap: () {
                  Get.to(() => Register());
                },
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Color(0xff000000)),
                ),
              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.forgotPassword);
                },
                child: const Text(
                  "Forget Password",
                  style: TextStyle(color: Color(0xff000000)),
                ),
              ),


              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
