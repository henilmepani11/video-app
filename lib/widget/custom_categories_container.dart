import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/constants.dart';

import 'custom_shimmer_container.dart';

class CustomCategoriesContainer extends StatelessWidget {
  final String videoTitleText;
  final String image;
  const CustomCategoriesContainer(
      {Key? key, required this.videoTitleText, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 88,
          width: 33.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.titleColor.withOpacity(0.1),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: image,
            placeholder: (context, url) => Shimmer.fromColors(
                highlightColor: AppColor.white.withOpacity(.7),
                baseColor: AppColor.grey,
                child:
                    const CustomShimmerContainer(height: 88, isRadius: true)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 6.43),
        Expanded(
          child: Text(videoTitleText,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyle.txt12W600HintColor1),
        ),
      ],
    );
  }
}
