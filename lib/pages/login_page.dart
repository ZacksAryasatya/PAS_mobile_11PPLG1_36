import 'package:flutter/gestures.dart'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/login_controller.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/text_field.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/button_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20), 
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Masuk untuk masuk ke akun kamu",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48), 
              CustomTextField(
                controller: controller.username,
                labelText: 'Username',
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.password,
                labelText: 'Password',
                icon: Icons.lock_outline_rounded,
                isObscure: true,
              ),
              const SizedBox(height: 32),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Frame4Button(
                  onPressed: () {
                    controller.login();
                  },
                  text: "Login",
                  width: double.infinity,
                  height: 50,
                  elevation: 2,
                  color: Color(0xFF42B6E7),
                );
              }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun?",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/registerpage'); 
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      minimumSize: const Size(10, 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Daftar di sini",
                      style: TextStyle(
                        color: Color(0xFF42B6E7),
                        fontWeight: FontWeight.bold,
                        fontSize: 14, 
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}