import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';

class CustomSeeAllContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final Function onTap;
  final TextStyle style;
  const CustomSeeAllContainer(
      {Key? key,
      this.height,
      this.width,
      this.text,
      required this.onTap,
      required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColor.primaryColor.withOpacity(0.15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text!, style: style),
            const SizedBox(width: 6),
            SvgPicture.asset(AppAssets.seeAllArrow)
          ],
        ),
      ),
    );
  }
}

// CustomTextStyle.txt9boldPrimary
