import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../views/widgets/root_page_widget.dart';
import '../../../views/widgets/text_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPageWidget(
      body: Center(
        child: TextButton(
          child:
              Container(color: Colors.amber, child: const TextCustom('Logout')),
          onPressed: () async {
            AuthService.signOut();
            Get.offAllNamed(Routes.REGISTER_PAGE);
          },
        ),
      ),
    );
  }
}
