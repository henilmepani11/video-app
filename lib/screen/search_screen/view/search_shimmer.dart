import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: AppColor.white.withOpacity(.7),
      baseColor: AppColor.grey,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomShimmerContainer(
                  width: 100, height: 71.43, isRadius: true),
              SizedBox(width: 2.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerContainer(
                        height: 2.h, width: 55.w, isRadius: true),
                    SizedBox(height: 1.5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmerContainer(
                            height: 2.h, width: 20.w, isRadius: true),
                        SizedBox(width: 2.5.w),
                        CustomShimmerContainer(
                            height: 2.h, width: 20.w, isRadius: true),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 1.5.h);
        },
      ),
    );
  }
}
