import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_36/models/register_model.dart';
import 'package:pas_mobile_11pplg1_36/network/network_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pas_mobile_11pplg1_36/routes/routes.dart';

class RegisterController extends GetxController {
	var isLoading = false.obs;
	var registerResponse = Rxn<RegisterModel>();

	final fullNameController = TextEditingController();
	final emailController = TextEditingController();
	final usernameController = TextEditingController();
  final passwordController = TextEditingController();

	  validateInput() {
		final fullname = fullNameController.text.trim();
		final email = emailController.text.trim();
		final username = usernameController.text.trim();
		final password = passwordController.text.trim();
		if (fullname.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty) {
			Get.snackbar('Error', 'Semua field harus diisi', snackPosition: SnackPosition.BOTTOM);
			return false;
		}
		if (!email.contains('@')) {
			Get.snackbar('Error', 'Email tidak valid', snackPosition: SnackPosition.BOTTOM);
			return false;
		}
		return true;
	}

	Future<void> register() async {
		if (!validateInput()) return;
		final url = Uri.parse('${NetworkApi.BASE_URL}api/latihan/register-user');
		try {
			isLoading.value = true;
			final res = await http.post(url, body: {
				'username': usernameController.text.trim(),
				'password': passwordController.text.trim(),
				'full_name': fullNameController.text.trim(),
				'email': emailController.text.trim(),
			});

			if (res.statusCode == 200) {
				final RegisterModel rm = RegisterModel.fromJson(json.decode(res.body));
				registerResponse.value = rm;
				if (rm.status == true) {
					final pref = await SharedPreferences.getInstance();
					await pref.setString('username', usernameController.text.trim());
					await pref.setString('email', emailController.text.trim());

					Get.snackbar('Berhasil', rm.message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
					fullNameController.clear();
					emailController.clear();
					usernameController.clear();
					passwordController.clear();
					Get.offAllNamed(AppRoutes.login);
				} else {
					Get.snackbar('Gagal', rm.message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.yellow, colorText: Colors.black);
				}
			} else {
				Get.snackbar('Gagal', 'Register gagal: status ${res.statusCode}', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
			}
		} catch (e) {
			Get.snackbar('Error', 'Koneksi gagal', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
			print('Error register: $e');
		} finally {
			isLoading.value = false;
		}
	}
}