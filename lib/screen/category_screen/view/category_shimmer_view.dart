import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';

class CategoryScreenAllCategoriesShimmer extends StatefulWidget {
  const CategoryScreenAllCategoriesShimmer({Key? key}) : super(key: key);

  @override
  State<CategoryScreenAllCategoriesShimmer> createState() =>
      _CategoryScreenAllCategoriesShimmerState();
}

class _CategoryScreenAllCategoriesShimmerState
    extends State<CategoryScreenAllCategoriesShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey,
      highlightColor: AppColor.white.withOpacity(.7),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomShimmerContainer(height: 1.8.h, width: 50.w, isRadius: true),
            SizedBox(height: 0.25.h),
            SizedBox(
              height: 70.h,
              child: Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 170,
                      mainAxisSpacing: 1.w,
                      crossAxisSpacing: 3.4.w,
                      crossAxisCount: 2,
                    ),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child:
                            CustomShimmerContainer(width: 43.w, isRadius: true),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryScreenFavouriteCategoriesShimmer extends StatelessWidget {
  const CategoryScreenFavouriteCategoriesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey,
      highlightColor: AppColor.white.withOpacity(.7),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.5.h),
            CustomShimmerContainer(height: 1.8.h, width: 50.w, isRadius: true),
            SizedBox(height: 1.h),
            SizedBox(
              height: 153,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 37.w,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmerContainer(height: 153, isRadius: true),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 3.w);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
