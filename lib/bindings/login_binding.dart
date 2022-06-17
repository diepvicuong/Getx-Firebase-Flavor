import 'package:get/instance_manager.dart';
import '../controllers/login/login_controller.dart';
import '../services/auth_service.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }
}
