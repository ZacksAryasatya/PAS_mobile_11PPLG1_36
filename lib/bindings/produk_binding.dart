import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/produk_controller.dart';

class ProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProdukController>(() => ProdukController());
  }
}