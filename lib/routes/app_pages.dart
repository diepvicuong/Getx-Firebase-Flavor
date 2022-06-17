import 'package:get/get.dart';
import '../bindings/login_binding.dart';
import '../views/pages/register/register_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => const RegisterPage(),
      binding: LoginBinding(),
    ),
  ];
}
