import 'package:flutter/material.dart';
import '../../../../utils/screen_utils.dart';
import '../../../../views/widgets/text_custom.dart';

class ButtonSNS extends StatelessWidget {
  final String iconAsset;
  final String title;
  final Color backgroundColor;
  final VoidCallback onTap;

  const ButtonSNS(
      {Key? key,
      required this.iconAsset,
      required this.title,
      required this.onTap,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtils.resizeHeightUtil(context, 50),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(ScreenUtils.resizeHeightUtil(context, 8)),
          color: backgroundColor),
      child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtils.resizeWidthUtil(context, 16)),
            child: Row(
              children: [
                Image.asset(
                  iconAsset,
                  width: ScreenUtils.resizeHeightUtil(context, 26),
                  height: ScreenUtils.resizeHeightUtil(context, 26),
                ),
                Expanded(
                  child: TextCustom(
                    title,
                    color: Colors.white,
                    fontSize: ScreenUtils.resizeHeightUtil(context, 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          onPressed: onTap),
    );
  }
}
