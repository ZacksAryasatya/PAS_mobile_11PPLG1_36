import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              const SizedBox(width: double.infinity),
              const Spacer(flex: 2), 
              const Icon(
                Icons.shopping_bag_outlined,
                size: 80,
                color: Color(0xFF42B6E7),
              ),
              const SizedBox(height: 24),
              const Text(
                "PAS Mobile",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Cintai usus mu,\n minum yakult tiap hari.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              const Spacer(flex: 1), 
              const CircularProgressIndicator(
                color: Color(0xFF42B6E7),
              ),
              SizedBox(height: 20),
              Text(
                "Memuat...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}