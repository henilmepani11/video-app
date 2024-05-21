import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class CategoryVideosScreenShimmer extends StatefulWidget {
  const CategoryVideosScreenShimmer({Key? key}) : super(key: key);

  @override
  State<CategoryVideosScreenShimmer> createState() =>
      _CategoryVideosScreenShimmerState();
}

class _CategoryVideosScreenShimmerState
    extends State<CategoryVideosScreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        highlightColor: AppColor.white.withOpacity(.7),
        baseColor: AppColor.grey,
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmerContainer(isRadius: true, width: 70.w, height: 2.h),
              SizedBox(height: 1.5.h),
              Row(
                children: [
                  CustomShimmerContainer(
                      isRadius: true, width: 15.w, height: 2.h),
                  SizedBox(width: 3.w),
                  CustomShimmerContainer(
                      isRadius: true, width: 15.w, height: 2.h),
                  SizedBox(width: 3.w),
                  CustomShimmerContainer(
                      isRadius: true, width: 15.w, height: 2.h),
                ],
              ),
              SizedBox(height: 3.h),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
