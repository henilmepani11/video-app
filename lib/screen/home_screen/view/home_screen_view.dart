import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/category_screen/controller/category_provider.dart';
import 'package:video_app/screen/category_screen/model/category_model.dart';
import 'package:video_app/screen/category_videos_screen/controller/category_video_provider.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';
import 'package:video_app/screen/home_screen/controller/home_provider.dart';
import 'package:video_app/screen/home_screen/view/home_shimmer_view.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_categories_container.dart';
import 'package:video_app/widget/custom_pop_categories_container.dart';
import 'package:video_app/widget/custom_see_all_container.dart';
import 'package:video_app/widget/custom_shimmer_container.dart';
import 'package:video_app/widget/scroll_configuration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeProvider homeProvider = Provider.of(context, listen: false);
    homeProvider.getSwiper();
    homeProvider.getPopularCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of(context, listen: false);
    CategoryVideoProvider categoryVideoProvider =
        Provider.of(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        leadingFunction: () {},
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(AppAssets.appLogo, height: 3.2.h),
            SizedBox(width: 1.5.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppString.alfred, style: CustomTextStyle.txt12boldWhite),
                SizedBox(width: 1.w),
                Text(AppString.little, style: CustomTextStyle.txt12White)
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(AppAssets.bell, height: 3.2.h),
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SafeArea(
          child: ListView(
            children: [
              Consumer<HomeProvider>(
                builder: (context, value, child) => homeProvider.isLoader ==
                        true
                    ? const HomeScreenSwiperShimmer()
                    : Stack(children: [
                        CarouselSlider(
                            items: homeProvider.showPopularCategoriesVideoList
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRouteString.videoScreen,
                                            arguments: VideoArguments(
                                              categoryId: e.categoryId,
                                              index: e.index,
                                              videoId: e.videoId,
                                              videoLink: e.videoLink,
                                            ));
                                      },
                                      child: SizedBox(
                                        height: 25.h,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: e.thumbnail.toString(),
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                                  highlightColor: AppColor.white
                                                      .withOpacity(.7),
                                                  baseColor: AppColor.grey,
                                                  child: CustomShimmerContainer(
                                                      height: 25.h)),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            options: CarouselOptions(
                              onPageChanged: (dm, h) {
                                homeProvider.sliderbox = dm;
                                homeProvider.notifyListeners();
                              },
                              height: 212,
                              aspectRatio: 16 / 10,
                              viewportFraction: 1.2,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 193),
                          child: Align(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: homeProvider
                                      .showPopularCategoriesVideoList
                                      .asMap()
                                      .map((key, value) => MapEntry(
                                          key,
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.5),
                                              child: AnimatedContainer(
                                                decoration: BoxDecoration(
                                                    color: homeProvider
                                                                .sliderbox ==
                                                            key
                                                        ? AppColor.primaryColor
                                                        : AppColor.titleColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                width: homeProvider.sliderbox ==
                                                        key
                                                    ? 12.sp
                                                    : 5.sp,
                                                height: 5.sp,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                              ))))
                                      .values
                                      .toList(),
                                ),
                              )),
                        ),
                      ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.w, top: 2.4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppString.popularCategories,
                        style: CustomTextStyle.txt14W700HintColor11
                            .copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Consumer<HomeProvider>(
                builder: (context, value, child) => homeProvider
                            .getPopularLoader ==
                        true
                    ? const HomeScreenPopularCategoriesShimmer()
                    : SizedBox(
                        height: 153,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              homeProvider.showPopularCategoriesList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                Get.toNamed(
                                  AppRouteString.categoryVideosScreen,
                                  arguments: CategoryVideosArguments(
                                    id: homeProvider
                                        .showPopularCategoriesList[index]
                                        .categoryId,
                                  ),
                                );
                                await categoryVideoProvider.getCategoryVideos(
                                    categoryId: homeProvider
                                        .showPopularCategoriesList[index]
                                        .categoryId);
                                await FirebaseFirestore.instance
                                    .collection("category")
                                    .doc(homeProvider
                                        .showPopularCategoriesList[index]
                                        .categoryId)
                                    .update({
                                  'total_view': FieldValue.increment(1)
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: CustomPopularCategoriesContainer(
                                    valueTrue: true,
                                    image: homeProvider
                                        .showPopularCategoriesList[index]
                                        .thumbnail,
                                    totalVideo: homeProvider
                                        .showPopularCategoriesList[index]
                                        .totalVideo,
                                    text: homeProvider
                                        .showPopularCategoriesList[index]
                                        .categoryName,
                                    isMoreIcon: false),
                              ),
                            );
                          },
                        ),
                      ),
              ),
              Consumer<CategoryProvider>(
                builder: (context, value, child) => StreamBuilder(
                  stream: value.categoryGetData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          CategoryModel categoryModel = CategoryModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3.w, top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      categoryModel.categoryName,
                                      style: CustomTextStyle
                                          .txt14W700HintColor11
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 3.w),
                                        child: CustomSeeAllContainer(
                                          style:
                                              CustomTextStyle.txt9boldPrimary,
                                          width: 22.w,
                                          height: 4.3.h,
                                          text: AppString.seeAll,
                                          onTap: () async {
                                            Get.toNamed(
                                              AppRouteString
                                                  .categoryVideosScreen,
                                              arguments:
                                                  CategoryVideosArguments(
                                                      id: categoryModel
                                                          .categoryId),
                                            );

                                            homeProvider.categoryViewUpdate(
                                                categoryId:
                                                    categoryModel.categoryId);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("video")
                                    .where("live", isEqualTo: true)
                                    .where("category_id",
                                        isEqualTo: categoryModel.categoryId)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                      height: 130,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data?.docs.length,
                                        itemBuilder: (context, index) {
                                          CategoryVideosModel
                                              categoryVideosModel =
                                              CategoryVideosModel.fromJson(
                                                  snapshot.data!.docs[index]
                                                          .data()
                                                      as Map<String, dynamic>);

                                          return GestureDetector(
                                            onTap: () async {
                                              Get.toNamed(
                                                  AppRouteString.videoScreen,
                                                  arguments: VideoArguments(
                                                    categoryId: categoryModel
                                                        .categoryId,
                                                    index: categoryVideosModel
                                                        .index,
                                                    videoId: categoryVideosModel
                                                        .videoId,
                                                    videoLink:
                                                        categoryVideosModel
                                                            .videoLink,
                                                  ));
                                            },
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 3.w, top: 10),
                                                child: SizedBox(
                                                  width: 140,
                                                  child:
                                                      CustomCategoriesContainer(
                                                    image: categoryVideosModel
                                                        .thumbnail
                                                        .toString(),
                                                    videoTitleText:
                                                        categoryVideosModel
                                                            .videoName
                                                            .toString(),
                                                  ),
                                                )),
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return const HomeVideoShimmer();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      return const HomeCategoryNameShimmer();
                    }
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
