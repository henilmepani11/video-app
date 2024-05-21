import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class HomeVideoShimmer extends StatefulWidget {
  const HomeVideoShimmer({Key? key}) : super(key: key);

  @override
  State<HomeVideoShimmer> createState() => _HomeVideoShimmerState();
}

class _HomeVideoShimmerState extends State<HomeVideoShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: AppColor.white.withOpacity(.7),
      baseColor: AppColor.grey,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.5.h),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Container(
                        width: 37.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmerContainer(height: 100, isRadius: true),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(height: 2.5.h),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Container(
                        width: 37.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmerContainer(height: 100, isRadius: true),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCategoryNameShimmer extends StatelessWidget {
  const HomeCategoryNameShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: AppColor.white.withOpacity(.7),
      baseColor: AppColor.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.5.h),
          Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: CustomShimmerContainer(
                  height: 1.8.h, width: 50.w, isRadius: true)),
          SizedBox(height: 16.h),
          Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: CustomShimmerContainer(
                  height: 1.8.h, width: 50.w, isRadius: true)),
        ],
      ),
    );
  }
}

class HomeScreenSwiperShimmer extends StatelessWidget {
  const HomeScreenSwiperShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: AppColor.white.withOpacity(.7),
        baseColor: AppColor.grey,
        child: const CustomShimmerContainer(height: 212));
  }
}

class HomeScreenPopularCategoriesShimmer extends StatelessWidget {
  const HomeScreenPopularCategoriesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: AppColor.white.withOpacity(.7),
      baseColor: AppColor.grey,
      child: SizedBox(
        height: 153,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: Container(
                width: 37.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerContainer(height: 153, isRadius: true),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
