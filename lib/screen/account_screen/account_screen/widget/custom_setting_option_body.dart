import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_color.dart';
import '../../../../config/constants.dart';

class CustomSettingOptionBody extends StatelessWidget {
  final Function onTap;
  final String text;
  final String image;
  const CustomSettingOptionBody(
      {Key? key, required this.onTap, required this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(image,
                      color: AppColor.textFieldHintColor1),
                ),
                const SizedBox(width: 10),
                Text(text, style: CustomTextStyle.txt13HintColor)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
