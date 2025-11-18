import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/register_controller.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/text_field.dart'; 
import 'package:pas_mobile_11pplg1_36/reuseable_component/button_widget.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/text_field.dart'; 

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Buat Akun Baru",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Isi data di bawah untuk mendaftar.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: controller.fullNameController,
                labelText: 'Nama Lengkap',
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.usernameController,
                labelText: 'Username',
                icon: Icons.alternate_email_rounded, 
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.emailController,
                labelText: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.passwordController,
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
                  onPressed: () => controller.register(),
                  text: "Daftar",
                  width: double.infinity, 
                  height: 50,
                  elevation: 2,
                  color: Color(0xFF42B6E7),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}