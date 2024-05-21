import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class VideoScreenShimmer extends StatefulWidget {
  const VideoScreenShimmer({Key? key}) : super(key: key);

  @override
  State<VideoScreenShimmer> createState() => _VideoScreenShimmerState();
}

class _VideoScreenShimmerState extends State<VideoScreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: AppColor.white.withOpacity(.7),
      baseColor: AppColor.grey,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Row(
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
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 1.5.h);
              },
            )
          ],
        ),
      ),
    );
  }
}

class VideoDetailsShimmer extends StatelessWidget {
  const VideoDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15),
      child: Shimmer.fromColors(
          highlightColor: AppColor.white.withOpacity(.7),
          baseColor: AppColor.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmerContainer(height: 2.h, width: 60.w, isRadius: true),
              SizedBox(height: 1.h),
              Row(
                children: [
                  CustomShimmerContainer(
                      height: 2.h, width: 13.w, isRadius: true),
                  SizedBox(width: 1.h),
                  CustomShimmerContainer(
                      height: 2.h, width: 13.w, isRadius: true),
                  SizedBox(width: 1.h),
                  CustomShimmerContainer(
                      height: 2.h, width: 13.w, isRadius: true),
                ],
              ),
              SizedBox(height: 2.h),
              CustomShimmerContainer(height: 2.h, width: 40.w, isRadius: true),
              SizedBox(height: 1.h),
              CustomShimmerContainer(height: 2.h, width: 13.w, isRadius: true),
            ],
          )),
    );
  }
}
