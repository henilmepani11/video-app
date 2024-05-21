import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeral/numeral.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/category_screen/controller/category_provider.dart';
import 'package:video_app/screen/category_screen/model/category_model.dart';
import 'package:video_app/screen/category_videos_screen/controller/category_video_provider.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';
import 'package:video_app/screen/category_videos_screen/view/category_videos_shimmer.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_video_details_container.dart';
import 'package:video_app/widget/scroll_configuration.dart';

class CategoryVideosScreen extends StatefulWidget {
  const CategoryVideosScreen({Key? key}) : super(key: key);

  @override
  State<CategoryVideosScreen> createState() => _CategoryVideosScreenState();
}

class _CategoryVideosScreenState extends State<CategoryVideosScreen> {
  bool isAddToInterest = false;

  @override
  void initState() {
    CategoryVideoProvider categoryVideoProvider =
        Provider.of(context, listen: false);

    categoryVideoProvider.getCategoryVideos(categoryId: args.id);
    super.initState();
  }

  final CategoryVideosArguments args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of(context, listen: false);
    CategoryVideoProvider categoryVideoProvider =
        Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () {
        isAddToInterest = false;
        categoryProvider.notifyListeners();
      },
      child: Scaffold(
        appBar: CustomAppBar(
            leadingFunction: () {},
            leadingValue: true,
            centerTitle: true,
            title: Text(AppString.videos,
                style: CustomTextStyle.txt20boldTitleColor)),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, top: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<CategoryVideoProvider>(
                    builder: (context, value, child) => categoryVideoProvider
                            .isLoader
                        ? const CategoryVideosScreenShimmer()
                        : StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("category")
                                .where("category_id", isEqualTo: args.id)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  return Expanded(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        CategoryModel categoryModel =
                                            CategoryModel.fromJson(snapshot
                                                    .data!.docs[index]
                                                    .data()
                                                as Map<String, dynamic>);
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              categoryModel
                                                                  .categoryName,
                                                              style: CustomTextStyle
                                                                  .txt14W600HintColor1
                                                                  .copyWith(
                                                                      fontSize:
                                                                          18,
                                                                      color: AppColor
                                                                          .textFieldHintColor1,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 1.2.h),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${categoryModel.totalVideo}\t${AppString.videosOneThree}",
                                                            style: CustomTextStyle
                                                                .txt14W600HintColorRoboto,
                                                          ),
                                                          SizedBox(width: 3.w),
                                                          Text(
                                                            "${Numeral(categoryModel.totalView).format(fractionDigits: 0)}\t${AppString.views}",
                                                            style: CustomTextStyle
                                                                .txt14W600HintColorRoboto,
                                                          ),
                                                          SizedBox(width: 3.w),
                                                          Text(
                                                            "${Numeral(categoryModel.totalFavorite).format(fractionDigits: 0)}\t${AppString.favSevenZeroFive}",
                                                            style: CustomTextStyle
                                                                .txt14W600HintColorRoboto,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Consumer<CategoryProvider>(
                                                  builder:
                                                      (context, value, child) =>
                                                          isAddToInterest ==
                                                                  true
                                                              ? Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 46,
                                                                  width: 157,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .addInterestBoxColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child: Text(
                                                                      AppString
                                                                          .addToInterest,
                                                                      style: CustomTextStyle
                                                                          .txt14W600HintColor
                                                                          .copyWith(
                                                                              color: AppColor.backgroundColor21)),
                                                                )
                                                              : Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              2.5.w),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      isAddToInterest =
                                                                          true;
                                                                      categoryProvider
                                                                          .notifyListeners();
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: AppColor
                                                                            .textFieldHintColor1),
                                                                  ),
                                                                ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 3.h),
                                            SizedBox(
                                              height: 400,
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("video")
                                                      .where("category_id",
                                                          isEqualTo: args.id)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    return SizedBox(
                                                      child: ListView.separated(
                                                        itemCount: snapshot.data
                                                                ?.docs.length ??
                                                            0,
                                                        itemBuilder:
                                                            (context, index) {
                                                          CategoryVideosModel
                                                              categoryVideosModel =
                                                              CategoryVideosModel
                                                                  .fromJson(snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .data());
                                                          return GestureDetector(
                                                              onTap: () {
                                                                Get.toNamed(
                                                                    AppRouteString
                                                                        .videoScreen,
                                                                    arguments:
                                                                        VideoArguments(
                                                                      categoryId: categoryVideoProvider
                                                                          .categoryVideosList[
                                                                              index]
                                                                          .categoryId,
                                                                      index: categoryVideoProvider
                                                                          .categoryVideosList[
                                                                              index]
                                                                          .index,
                                                                      videoId: categoryVideoProvider
                                                                          .categoryVideosList[
                                                                              index]
                                                                          .videoId,
                                                                      videoLink: categoryVideoProvider
                                                                          .categoryVideosList[
                                                                              index]
                                                                          .videoLink,
                                                                    ));
                                                              },
                                                              child: Container(
                                                                color: AppColor
                                                                    .backgroundColor20,
                                                                width: double
                                                                    .infinity,
                                                                child: CustomVideoDetailsContainer(
                                                                    valueTrue:
                                                                        true,
                                                                    fav: categoryVideosModel
                                                                        .totalFavorite,
                                                                    view: categoryVideosModel
                                                                        .totalView,
                                                                    image: categoryVideosModel
                                                                        .thumbnail,
                                                                    titleText:
                                                                        categoryVideosModel
                                                                            .videoName,
                                                                    isMoreIcon:
                                                                        false),
                                                              ));
                                                        },
                                                        separatorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return SizedBox(
                                                              height: 1.5.h);
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
