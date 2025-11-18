import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_36/models/produk_model.dart';
import 'package:pas_mobile_11pplg1_36/network/network_api.dart';
import 'package:pas_mobile_11pplg1_36/package_helper/database_helper.dart';

class ProdukController extends GetxController {
  // State
  var isLoading = false.obs;
  var produkList = <ProdukModel>[].obs;
  var bookmarkList = <Map<String, dynamic>>[].obs;
  var bookmarkedIds = RxSet<int>();

  final dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchProduk();
    loadBookmarks();
  }

  // Parse category string to enum
  Category parseCategory(String categoryStr) {
    categoryStr = categoryStr.toLowerCase().replaceAll(' ', '_');
    if (categoryStr == 'electronics') return Category.ELECTRONICS;
    if (categoryStr == 'jewelery') return Category.JEWELERY;
    if (categoryStr == "men's clothing" || categoryStr == 'mens_clothing') {
      return Category.MEN_S_CLOTHING;
    }
    if (categoryStr == "women's clothing" || categoryStr == 'womens_clothing') {
      return Category.WOMEN_S_CLOTHING;
    }
    return Category.ELECTRONICS;
  }

  Future<void> fetchProduk() async {
    isLoading.value = true;
    try {
      final url = Uri.parse('${NetworkApi.BASE_URL_1}products');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        produkList.value = data.map((item) {
          return ProdukModel(
            id: item['id'],
            title: item['title'] ?? '',
            price: (item['price'] as num).toDouble(),
            description: item['description'] ?? '',
            category: parseCategory(item['category'] ?? 'electronics'),
            image: item['image'] ?? '',
            rating: Rating(
              rate: ((item['rating']?['rate'] ?? 0) as num).toDouble(),
              count: item['rating']?['count'] ?? 0,
            ),
          );
        }).toList();
        Get.snackbar('Success', 'Produk berhasil dimuat', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Gagal memuat produk', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Koneksi gagal: $e', snackPosition: SnackPosition.BOTTOM);
      print('Error fetchProduk: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadBookmarks() async {
    try {
      final bookmarks = await dbHelper.getBookmarks();
      bookmarkList.value = bookmarks;
      bookmarkedIds.addAll(bookmarks.map((b) => b['product_id'] as int));
    } catch (e) {
      print('Error loadBookmarks: $e');
    }
  }

  Future<void> toggleBookmark(ProdukModel produk) async {
    try {
      final isBookmarked = bookmarkedIds.contains(produk.id);
      if (isBookmarked) {
        await dbHelper.deleteBookmarkByProductId(produk.id!);
        bookmarkedIds.remove(produk.id);
        Get.snackbar('Info', 'Bookmark dihapus', snackPosition: SnackPosition.BOTTOM);
      } else {
        await dbHelper.insertBookmark({
          'product_id': produk.id,
          'title': produk.title,
          'price': produk.price,
          'description': produk.description,
          'category': produk.category.toString(),
          'image': produk.image,
          'rating': produk.rating.rate,
          'rating_count': produk.rating.count,
        });
        bookmarkedIds.add(produk.id!);
        Get.snackbar('Info', 'Ditambahkan ke bookmark', snackPosition: SnackPosition.BOTTOM);
      }
      await loadBookmarks();
    } catch (e) {
      Get.snackbar('Error', 'Gagal toggle bookmark: $e', snackPosition: SnackPosition.BOTTOM);
      print('Error toggleBookmark: $e');
    }
  }

  Future<void> deleteBookmark(int productId) async {
    try {
      await dbHelper.deleteBookmarkByProductId(productId);
      bookmarkedIds.remove(productId);
      await loadBookmarks();
      Get.snackbar('Info', 'Bookmark dihapus', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Gagal hapus bookmark: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }
}