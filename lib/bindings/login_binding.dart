import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}