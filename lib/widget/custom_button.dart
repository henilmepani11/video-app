import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double? width;
  final double? height;
  final bool isBack;
  final Color? color;
  final TextStyle? textStyle;
  final bool boxShadow;

  final bool? loader;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.width,
      this.isBack = false,
      this.color,
      this.height,
      this.textStyle,
      this.boxShadow = false,
      this.loader = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(right: 3.w),
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: boxShadow == true
                    ? AppColor.signInboxShadowColor.withOpacity(0.16)
                    : AppColor.boxShadowColor.withOpacity(0.16),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ], color: color, borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isBack == true
                  ? SvgPicture.asset(AppAssets.signOutback, height: 3.h)
                  : const SizedBox.shrink(),
              SizedBox(width: 2.5.w),
              loader == true
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: AppColor.white,
                    ))
                  : Center(
                      child: Text(
                      text,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
