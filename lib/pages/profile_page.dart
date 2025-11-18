import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pas_mobile_11pplg1_36/controllers/login_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final LoginController logoutController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final prefs = snapshot.data!;
          final username = prefs.getString('username') ?? 'Guest';
          final email = prefs.getString('email') ?? 'email@example.com';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 30),
                const Text(
                  'User Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Username: $username',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: $email',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Frame4Button(
                    onPressed: () {
                      logoutController.logout();
                    },
                    text: "Logout",
                    width: 120,
                    height: 40,
                    elevation: 4,
                    color: Color(0xFF42B6E7),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
