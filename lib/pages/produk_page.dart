import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/produk_controller.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/product_card.dart';

class ProdukPage extends StatelessWidget {
  ProdukPage({super.key});

  final controller = Get.find<ProdukController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.produkList.isEmpty) {
            return const Center(child: Text('Tidak ada produk'));
          }
          return RefreshIndicator(
            onRefresh: () => controller.fetchProduk(),
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.65,
              ),
              itemCount: controller.produkList.length,
              itemBuilder: (context, index) {
                final produk = controller.produkList[index];
                return Obx(
                  () {
                    final isBookmarked = controller.bookmarkedIds.contains(produk.id);
                    return ProductCard(
                      produk: produk,
                      isBookmarked: isBookmarked,
                      onToggleBookmark: () => controller.toggleBookmark(produk),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}