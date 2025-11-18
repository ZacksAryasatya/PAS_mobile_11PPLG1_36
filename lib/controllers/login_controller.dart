import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_36/models/login_model.dart';
import 'package:pas_mobile_11pplg1_36/network/network_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pas_mobile_11pplg1_36/routes/routes.dart';

class LoginController extends GetxController{
  final username = TextEditingController();
  final password = TextEditingController();
  var loginResponse = Rxn<LoginModel>();
  var isLoading = false.obs;
  void login() async {
    String usernameToString = username.text.trim();
    String passwordToString = password.text.trim();

    final url = Uri.parse("${NetworkApi.BASE_URL}api/latihan/login");

    try {
      isLoading.value = true;
      final res = await http.post(
        url,
        body: {"username": usernameToString, "password": passwordToString},
      );

      if (res.statusCode == 200) {
        final LoginModel loginModel = loginModelFromJson(res.body);
        loginResponse.value = loginModel;

        if (loginModel.status == true) {
          final pref = await SharedPreferences.getInstance();
          pref.setString("token", loginModel.token.toString());
          Get.offNamed(AppRoutes.dashboard);
        } else {
          Get.snackbar(
            "Auth",
            loginModel.message,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.black,
          );
        }
      } else {
        Get.snackbar(
          "Auth",
          "Login Gagal: Status ${res.statusCode}",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.black,
        );
      } 
    } catch (e) {
      Get.snackbar(
        "Auth",
        "Koneksi Gagal",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      final pref = await SharedPreferences.getInstance();
      await pref.remove('token');
      await pref.remove('username');
      loginResponse.value = null;
      username.clear();
      password.clear();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', 'Gagal logout', snackPosition: SnackPosition.TOP);
    }
  }
}