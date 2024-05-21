import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class CustomPopularCategoriesContainer extends StatelessWidget {
  final bool isMoreIcon;
  final String? text;
  final String? image;
  final int? totalVideo;
  final bool? valueTrue;
  final Function? onTapMore;

  const CustomPopularCategoriesContainer(
      {Key? key,
      required this.isMoreIcon,
      this.text,
      this.totalVideo,
      this.image,
      this.valueTrue,
      this.onTapMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 37.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.titleColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6), topLeft: Radius.circular(6)),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: image ?? '',
                placeholder: (context, url) => Shimmer.fromColors(
                    highlightColor: AppColor.white.withOpacity(.7),
                    baseColor: AppColor.grey,
                    child: const CustomShimmerContainer(
                        height: 100, isRadius: true)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(text.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.txt14W600HintColor1),
                ),
              ),
              isMoreIcon == true
                  ? GestureDetector(
                      onTapDown: (details) {
                        onTapMore!(details);
                      },
                      child: SizedBox(
                          height: 10,
                          child: Icon(
                            size: 21,
                            color: AppColor.textFieldHintColor1.withOpacity(.5),
                            Icons.more_vert,
                          )),
                    )
                  : const SizedBox()
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.5.w),
                child: Text(
                  totalVideo.toString(),
                  style: CustomTextStyle.txt14W600HintColorRoboto,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                AppString.videos,
                style: CustomTextStyle.txt14W600HintColorRoboto,
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
