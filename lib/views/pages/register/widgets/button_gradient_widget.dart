import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../utils/screen_utils.dart';
import '../../../../views/widgets/text_custom.dart';

class ButtonGradientWidget extends StatelessWidget {
  final String title;
  final Gradient? gradient;
  final VoidCallback? onTap;
  const ButtonGradientWidget(
      {Key? key, required this.title, this.gradient, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtils.resizeHeightUtil(context, 54),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(ScreenUtils.resizeHeightUtil(context, 26)),
        gradient: gradient ?? AppColor.btnRegisterGradient,
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        padding: EdgeInsets.zero,
        child: TextCustom(
          title,
          color: Colors.white,
          fontSize: ScreenUtils.resizeHeightUtil(context, 16),
        ),
        onPressed: onTap,
      ),
    );
  }
}
