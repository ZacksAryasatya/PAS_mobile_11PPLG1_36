import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/button_widget.dart';
import 'package:pas_mobile_11pplg1_36/controllers/login_controller.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/profile_info.dart'; 

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text(
          'Profile Page', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[100],
              backgroundImage: AssetImage("assets/foto1.jpg"), 
            ),
            const SizedBox(height: 16),
            const Text(
              "Zaky Ganteng", 
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "zack@gmail.com",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            const ProfileInfo(
              icon: Icons.person_outline,
              label: "Username",
              value: "Zaky GAnteng", 
            ),
            const SizedBox(height: 12),
            const ProfileInfo(
              icon: Icons.email_outlined,
              label: "Email",
              value: "zack@gmail.com", 
            ),
            const Spacer(), 
            Frame4Button(
              onPressed: () {
                controller.logout(); 
              },
              text: "Logout",
              width: double.infinity, 
              height: 50,
              elevation: 0, 
              color: Colors.red[50]!, 
              textStyle: const TextStyle(
                color: Colors.red, 
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16), 
          ],
        ),
      ),
    );
  }
}