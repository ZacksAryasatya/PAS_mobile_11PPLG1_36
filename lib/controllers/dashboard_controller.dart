import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/pages/favorite_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/produk_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/profile_page.dart';

final List<Widget> pages = [ProdukPage(), FavoritePage(), ProfilePage()];

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  void changetabIndex(int index) {
    selectedIndex.value = index;
  }
}
