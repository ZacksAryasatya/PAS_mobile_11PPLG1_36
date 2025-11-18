import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_36/models/produk_model.dart';
import 'package:pas_mobile_11pplg1_36/network/network_api.dart';
import 'package:pas_mobile_11pplg1_36/package_helper/database_helper.dart';

class ProdukController extends GetxController {
  var isLoading = false.obs;
  var produkList = <ProductModel>[].obs;
  var bookmarkList = <Map<String, dynamic>>[].obs;
  var bookmarkedIds = RxSet<int>();

  final dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadBookmarks();
    await fetchProduk();
  }
  Future<void> fetchProduk() async {
    isLoading.value = true;
    try {
      final url = Uri.parse('${NetworkApi.BASE_URL_1}products');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        produkList.value = data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        Get.snackbar('Error', 'gagal ngeload product',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'Koneksi gagal: $e',
          snackPosition: SnackPosition.TOP);
      print('Error fetchProduk: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadBookmarks() async {
    try {
      final bookmarks = await dbHelper.getBookmarks();
      bookmarkList.value = bookmarks;
      bookmarkedIds.value = bookmarks.map((b) => b['product_id'] as int).toSet();

    } catch (e) {
      print('Error loadBookmarkss: $e');
    }
  }

  Future<void> toggleBookmark(ProductModel produk) async {
    try {
      final isBookmarked = bookmarkedIds.contains(produk.id);
      
      if (isBookmarked) {
        await dbHelper.deleteBookmarkByProductId(produk.id);
      } else {
        await dbHelper.insertBookmark(produk.toMapForDb());
      }
      await loadBookmarks();

    } catch (e) {
      Get.snackbar('Error', 'Gagal nge toggel icon bookmark: $e',
          snackPosition: SnackPosition.TOP);
      print('Error toggleBookmark: $e');
    }
  }

  Future<void> deleteBookmark(int productId) async {
    try {
      await dbHelper.deleteBookmarkByProductId(productId);
      await loadBookmarks(); 
    } catch (e) {
      Get.snackbar('Error', 'Gagal ngapus bookmark: $e',
          snackPosition: SnackPosition.TOP);
    }
  }
}