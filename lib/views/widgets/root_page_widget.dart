import 'package:flutter/material.dart';

class RootPageWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  const RootPageWidget({Key? key, this.appBar, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          left: false,
          top: true,
          bottom: false,
          child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: body)),
    );
  }
}
