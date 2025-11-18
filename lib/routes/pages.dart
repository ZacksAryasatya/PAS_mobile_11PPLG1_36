import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_36/bindings/dashboard_binding.dart';
import 'package:pas_mobile_11pplg1_36/bindings/login_binding.dart';
import 'package:pas_mobile_11pplg1_36/bindings/produk_binding.dart';
import 'package:pas_mobile_11pplg1_36/bindings/register_binding.dart';
import 'package:pas_mobile_11pplg1_36/bindings/splash_binding.dart';
import 'package:pas_mobile_11pplg1_36/pages/favorite_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/login_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/dashboard_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/produk_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/profile_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/register_page.dart';
import 'package:pas_mobile_11pplg1_36/pages/splash_screen.dart';
import 'package:pas_mobile_11pplg1_36/routes/routes.dart';

class AppPages {
  static final pages = 
  [
    GetPage(
      name: AppRoutes.dashboard, 
      page: () => DashboardPage(),
      bindings: [DashboardBinding(), ProdukBinding(), LoginBinding()]
    ),
    GetPage(
      name: AppRoutes.splash, 
      page: () => SplashScreen(),
      binding: SplashBinding()
    ),
    GetPage(
      name: AppRoutes.register, 
      page: () => RegisterPage(),
      binding: RegisterBinding()
    ),
    GetPage(
      name: AppRoutes.login, 
      page: () => LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
      name: AppRoutes.produk, 
      page: () => ProdukPage(),
      binding: ProdukBinding()
    ),
    GetPage(
      name: AppRoutes.profile, 
      page: () => ProfilePage(),
      binding: LoginBinding()
    ),
  ];

}
