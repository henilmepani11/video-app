import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class AllCategoriesContainer extends StatelessWidget {
  final String? titleText;
  final int? intTotalVideos;
  final String? image;
  const AllCategoriesContainer(
      {Key? key, this.titleText, this.intTotalVideos, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 159.44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.titleColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 113.89,
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
                imageUrl: image ?? "",
                placeholder: (context, url) => Shimmer.fromColors(
                    highlightColor: AppColor.white.withOpacity(.7),
                    baseColor: AppColor.grey,
                    child: const CustomShimmerContainer(
                        height: 113, isRadius: true)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 9),
            child: Text(titleText!,
                style: CustomTextStyle.txt14W600HintColor1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Text(
                  intTotalVideos.toString(),
                  style: CustomTextStyle.txt14W600HintColorRoboto,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                AppString.totalVideos,
                style: CustomTextStyle.txt14W600HintColorRoboto,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
