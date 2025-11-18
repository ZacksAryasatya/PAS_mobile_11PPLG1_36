import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/produk_controller.dart';
import 'package:pas_mobile_11pplg1_36/reuseable_component/bookmark_card.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});
  final controller = Get.find<ProdukController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text(
          'Favorite Product', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22, 
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, 
      ),
      body: Obx(
        () {
          if (controller.bookmarkList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded, 
                    size: 80, 
                    color: Colors.grey[300], 
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Belom Ada Favorite Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Simpen produk yang di sukain',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: controller.bookmarkList.length,
            itemBuilder: (context, index) {
              final bookmark = controller.bookmarkList[index];
              final productId = bookmark['product_id'] as int;
              return FavoriteCard(
                favorite: bookmark,
                onDelete: () {
                  controller.deleteBookmark(productId);
                },
              );
            },
          );
        },
      ),
    );
  }
}