import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numeral/numeral.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class CustomVideoDetailsContainer extends StatefulWidget {
  final bool? isMoreIcon;
  final String? titleText;
  final String? image;
  final int? view;
  final int? fav;
  final bool valueTrue;
  final Function? onTapMore;
  const CustomVideoDetailsContainer({
    Key? key,
    this.isMoreIcon = false,
    this.titleText,
    this.image,
    this.view,
    this.fav,
    this.valueTrue = false,
    this.onTapMore,
  }) : super(key: key);

  @override
  State<CustomVideoDetailsContainer> createState() =>
      _CustomVideoDetailsContainerState();
}

class _CustomVideoDetailsContainerState
    extends State<CustomVideoDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 71.43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.textFieldHintColor,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6), topLeft: Radius.circular(6)),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.image!,
                  placeholder: (context, url) => Shimmer.fromColors(
                      highlightColor: AppColor.white.withOpacity(.7),
                      baseColor: AppColor.grey,
                      child: const CustomShimmerContainer(
                          height: 71.43, isRadius: true)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 2.5.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.titleText.toString(),
                      style: CustomTextStyle.txt11W600HintColorRoboto
                          .copyWith(fontSize: 11.5.sp),
                    ),
                  ),
                  widget.isMoreIcon == true
                      ? Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: GestureDetector(
                              onTapDown: (details) {
                                widget.onTapMore!(details);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: SvgPicture.asset(AppAssets.menu),
                              )),
                        )
                      : const SizedBox()
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Builder(builder: (context) {
                    return Text(
                      "${Numeral(widget.view ?? 0).format(fractionDigits: 0)}\t${AppString.views}",
                      style: CustomTextStyle.txt14W600HintColorRoboto,
                    );
                  }),
                  SizedBox(width: 2.5.w),
                  Text(
                    "${Numeral(widget.fav ?? 0).format(fractionDigits: 0)}\t${AppString.fav}",
                    style: CustomTextStyle.txt14W600HintColorRoboto,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
