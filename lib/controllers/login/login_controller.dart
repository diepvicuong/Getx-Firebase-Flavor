import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import 'package:get/get.dart';
import '../../views/widgets/dialog_custom.dart';

import '../../utils/logger.dart';

enum AuthMethod { Email, Google, Facebook, Twitter, Apple }

class LoginController extends GetxController {
  final AuthService _authService;

  LoginController(AuthService authService) : _authService = authService;

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> signup(
      {String? email,
      String? password,
      AuthMethod method = AuthMethod.Email}) async {
    try {
      setLoading(true);
      User? user;
      switch (method) {
        case AuthMethod.Email:
          if (email != null && password != null) {
            user = await _authService.signUp(email: email, password: password);
          }
          break;
        case AuthMethod.Google:
          user = await _authService.signInWithGoogle();
          break;
        case AuthMethod.Facebook:
          user = await _authService.signInWithFacebook();
          break;
        case AuthMethod.Twitter:
          user = await _authService.signInWithTwitter();
          break;
        case AuthMethod.Apple:
          user = await _authService.signInWithApple();
          break;
        default:
      }

      setLoading(false);
      update();
    } on FirebaseAuthException catch (exc) {
      MyLogger.d(exc.toString());
      if (exc.code == 'email-already-in-use') {
        BaseDialog.showAlertDialog('emailAlreadyInUse'.tr);
      } else if (exc.code == 'invalid-email') {
        BaseDialog.showAlertDialog('invalidEmail'.tr);
      } else if (exc.code == 'weak-password') {
        BaseDialog.showAlertDialog('weakPassword'.tr);
      } else {
        BaseDialog.showAlertDialog('invalidEmail'.tr);
      }
    } finally {
      setLoading(false);
    }

    return false;
  }

  void setLoading(bool value) {
    _isLoading.value = value;
  }
}
