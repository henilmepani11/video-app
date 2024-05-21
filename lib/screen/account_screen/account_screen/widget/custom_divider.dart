import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, right: 6.w, top: 2.5.h),
      child: Container(
        height: 0.6,
        color: AppColor.dividerColor1,
      ),
    );
  }
}
