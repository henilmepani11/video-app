import 'package:flutter/cupertino.dart';
import 'package:video_app/config/app_color.dart';

class CustomShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? isRadius;
  const CustomShimmerContainer(
      {Key? key, this.height, this.width, this.isRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: isRadius == true ? BorderRadius.circular(6) : null,
        color: AppColor.grey,
      ),
      height: height,
      width: width,
    );
  }
}
