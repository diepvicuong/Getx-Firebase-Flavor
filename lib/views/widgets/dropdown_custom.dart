import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../utils/screen_utils.dart';
import 'text_custom.dart';

class DropdownCustom extends StatelessWidget {
  final String title;
  final String? hintText;

  final String? value;

  final List<DropdownMenuItem<String>>? items;
  final Function(String?)? onChanged;

  const DropdownCustom(
      {Key? key,
      required this.title,
      this.hintText,
      this.value,
      this.items,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCustom(
          title,
          fontSize: ScreenUtils.resizeHeightUtil(context, 13),
        ),
        SizedBox(height: ScreenUtils.resizeHeightUtil(context, 8)),
        Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(ScreenUtils.resizeHeightUtil(context, 8)),
            color: AppColor.tfBackgroundColor,
          ),
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtils.resizeHeightUtil(context, 12),
              horizontal: ScreenUtils.resizeWidthUtil(context, 16)),
          alignment: Alignment.center,
          child: DropdownButton<String>(
            value: value,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColor.txtPrimaryColor,
            ),
            isExpanded: true,
            elevation: 16,
            isDense: true,
            // style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 0,
            ),
            hint: TextCustom(
              hintText ?? '',
              color: AppColor.txtHintColor,
            ),
            onChanged: onChanged,
            items: items,
          ),
        ),
      ],
    );
  }
}
