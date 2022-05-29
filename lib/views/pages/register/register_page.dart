import 'dart:io';

import 'package:flutter/material.dart';
import '../../../config/app_size.dart';
import '../../../config/theme/app_colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../views/pages/register/widgets/button_gradient_widget.dart';
import '../../../views/widgets/loading_custom.dart';
import '../../../views/widgets/root_page_widget.dart';
import '../../../views/widgets/text_custom.dart';
import 'package:get/get.dart';

import '../../../controllers/login/login_controller.dart';
import 'widgets/button_sns_widget.dart';
import 'widgets/dash_divider_widget.dart';
import '../../../utils/extensions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>(); //for storing form state.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginController = Get.find<LoginController>();

  bool isFirstValidate = true;

  Future doSignup({required String username, required String password}) async {
    isFirstValidate = false;
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      FocusManager.instance.primaryFocus?.unfocus();
      final isSuccess = await loginController.signup(
        email: emailController.text,
        password: passwordController.text,
      );

      if (isSuccess) {}
    }
  }

  Future doSignupSNS({required AuthMethod method}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final isSuccess = await loginController.signup(method: method);

    if (isSuccess) {}
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootPageWidget(
        body: Stack(
      children: [
        SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtils.resizeWidthUtil(
                    context, AppSize.paddingRegisterPage)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 33)),
                TextCustom(
                  'logo'.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtils.resizeHeightUtil(context, 32),
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 32)),
                TextCustom(
                  'registerNewUser'.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtils.resizeHeightUtil(context, 18),
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 24)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      'emailTitle'.tr,
                      fontSize: ScreenUtils.resizeHeightUtil(context, 13),
                    ),
                    SizedBox(height: ScreenUtils.resizeHeightUtil(context, 8)),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ScreenUtils.resizeHeightUtil(context, 8)),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'emailHint'.tr,
                        hintStyle: TextStyle(
                          fontSize: ScreenUtils.resizeHeightUtil(context, 16),
                          color: AppColor.txtHintColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: ScreenUtils.resizeHeightUtil(context, 12),
                            horizontal:
                                ScreenUtils.resizeWidthUtil(context, 16)),
                        filled: true,
                        fillColor: AppColor.tfBackgroundColor,
                      ),
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return 'emailRequired'.tr;
                        } else if (!text.isValidEmail) {
                          return 'invalidEmail'.tr;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (isFirstValidate == false) {
                          formKey.currentState?.validate();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 24)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      'passwordTitle'.tr,
                      fontSize: ScreenUtils.resizeHeightUtil(context, 13),
                    ),
                    SizedBox(height: ScreenUtils.resizeHeightUtil(context, 8)),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ScreenUtils.resizeHeightUtil(context, 8)),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'passwordHint'.tr,
                        hintStyle: TextStyle(
                          fontSize: ScreenUtils.resizeHeightUtil(context, 16),
                          color: AppColor.txtHintColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: ScreenUtils.resizeHeightUtil(context, 12),
                            horizontal:
                                ScreenUtils.resizeWidthUtil(context, 16)),
                        filled: true,
                        fillColor: AppColor.tfBackgroundColor,
                      ),
                      obscureText: true,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return 'passwordRequired'.tr;
                        }

                        return null;
                      },
                      onChanged: (value) {
                        if (isFirstValidate == false) {
                          formKey.currentState?.validate();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 48)),
                ButtonGradientWidget(
                  title: 'btnRegister'.tr,
                  onTap: () {
                    doSignup(
                        username: emailController.text.trim(),
                        password: passwordController.text.trim());
                  },
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 36)),
                const DashDivider(
                  color: Color(0xff143966),
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 36)),
                ButtonSNS(
                  iconAsset: 'assets/icons/ic_facebook.png',
                  title: 'btnFacebook'.tr,
                  backgroundColor: const Color(0xFF3975E9),
                  onTap: () {
                    doSignupSNS(method: AuthMethod.Facebook);
                  },
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 12)),
                ButtonSNS(
                  iconAsset: 'assets/icons/ic_google.png',
                  title: 'btnGmail'.tr,
                  backgroundColor: const Color(0xFFDC4B38),
                  onTap: () {
                    doSignupSNS(method: AuthMethod.Google);
                  },
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 12)),
                ButtonSNS(
                  iconAsset: 'assets/icons/ic_twitter.png',
                  title: 'btnTwitter'.tr,
                  backgroundColor: const Color(0xFF00ACEE),
                  onTap: () {
                    doSignupSNS(method: AuthMethod.Twitter);
                  },
                ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 12)),
                if (Platform.isIOS)
                  ButtonSNS(
                    iconAsset: 'assets/icons/ic_twitter.png',
                    title: 'btnApple'.tr,
                    backgroundColor: Colors.grey,
                    onTap: () {
                      doSignupSNS(method: AuthMethod.Apple);
                    },
                  ),
                SizedBox(height: ScreenUtils.resizeHeightUtil(context, 12)),
              ],
            ),
          ),
        )),
        Obx(
          () => loginController.isLoading
              ? const LoadingCustom()
              : const SizedBox.shrink(),
        )
      ],
    ));
  }
}
