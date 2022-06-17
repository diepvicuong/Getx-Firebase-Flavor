import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/app_setting.dart';

import 'config/theme/app_colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  //Custom debugPrint
  bool isRelease = false;
  if (isRelease) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  } else {
    debugPrint = (String? message, {int? wrapWidth}) =>
        debugPrintSynchronouslyWithText(message, wrapWidth: null);
  }

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runZonedGuarded(() {
    runApp(MyApp());
  }, (e, s) {
    // Log Firebase crashlytics
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppSetting.appTitle,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: AppColor.backgroundColor),
      initialRoute: Routes.REGISTER_PAGE,
      getPages: AppPages.pages,
    );
  }
}

void debugPrintSynchronouslyWithText(String? message, {int? wrapWidth}) {
  message = '[${DateTime.now()}]: $message';
  debugPrintSynchronously(message, wrapWidth: wrapWidth);
}
