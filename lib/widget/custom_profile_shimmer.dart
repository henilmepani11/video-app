import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_app/config/app_color.dart';

class CustomProfileShimmer extends StatelessWidget {
  const CustomProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: AppColor.white.withOpacity(.7),
      baseColor: AppColor.grey,
      child: CircleAvatar(
        radius: 54,
        backgroundColor: AppColor.white,
      ),
    );
  }
}
