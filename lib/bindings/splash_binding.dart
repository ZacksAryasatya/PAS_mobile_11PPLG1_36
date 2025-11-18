import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}