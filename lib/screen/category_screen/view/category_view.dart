import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/category_screen/controller/category_provider.dart';
import 'package:video_app/screen/category_screen/model/category_model.dart';
import 'package:video_app/screen/category_screen/view/category_shimmer_view.dart';
import 'package:video_app/screen/favourite_screen/controller/favorite_provider.dart';
import 'package:video_app/screen/video_screen/controller/video_provider.dart';
import 'package:video_app/widget/all_categories_container.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_pop_categories_container.dart';
import 'package:video_app/widget/scroll_configuration.dart';
import 'package:video_app/widget/show_menu.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    initCallFunction();
    super.initState();
  }

  initCallFunction() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VideoProvider videoProvider = Provider.of(context, listen: false);
      AppProvider appProvider = Provider.of(context, listen: false);
      videoProvider.getFavoriteCategories(context: context);
      appProvider.storeCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of(context, listen: false);
    VideoProvider videoProvider = Provider.of(context, listen: false);
    AppProvider appProvider = Provider.of(context, listen: false);
    return Consumer<VideoProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: CustomAppBar(
          leadingFunction: () {},
          centerTitle: true,
          title: Text(AppString.categories,
              style: CustomTextStyle.txt20boldTitleColor),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 17),
              child: GestureDetector(
                onTap: () {
                  appProvider.selectindex = 1;
                  appProvider.notifyListeners();
                },
                child: SvgPicture.asset(AppAssets.search,
                    color: AppColor.white, height: 24, width: 24),
              ),
            )
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<FavoriteProvider>(
                        builder: (context, value, child) => videoProvider
                                    .favoriteCategoryLoader ==
                                true
                            ? const CategoryScreenFavouriteCategoriesShimmer()
                            : videoProvider.favoriteCategoryList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          AppString.favoriteCategories,
                                          style: CustomTextStyle
                                              .txt14W700HintColor11,
                                        ),
                                      ),
                                      const SizedBox(height: 9),
                                      SizedBox(
                                        height: 153,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: videoProvider
                                              .favoriteCategoryList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                Get.toNamed(
                                                  AppRouteString
                                                      .categoryVideosScreen,
                                                  arguments:
                                                      CategoryVideosArguments(
                                                    id: videoProvider
                                                        .favoriteCategoryList[
                                                            index]
                                                        .categoryId,
                                                  ),
                                                );
                                                await FirebaseFirestore.instance
                                                    .collection("category")
                                                    .doc(videoProvider
                                                        .favoriteCategoryList[
                                                            index]
                                                        .categoryId)
                                                    .update({
                                                  'total_view':
                                                      FieldValue.increment(1)
                                                });
                                              },
                                              child:
                                                  CustomPopularCategoriesContainer(
                                                      onTapMore: (TapDownDetails
                                                          details) {
                                                        showPopupMenu(
                                                            onTap: () {
                                                              videoProvider.categoryDelete(
                                                                  argumentCategory: videoProvider
                                                                      .favoriteCategoryList[
                                                                          index]
                                                                      .categoryId,
                                                                  context:
                                                                      context);

                                                              appProvider
                                                                  .getUserProfile();

                                                              appProvider
                                                                  .getLocalData();
                                                            },
                                                            offset: details
                                                                .globalPosition,
                                                            context: context);
                                                      },
                                                      valueTrue: true,
                                                      image: videoProvider
                                                          .favoriteCategoryList[
                                                              index]
                                                          .thumbnail,
                                                      totalVideo: videoProvider
                                                          .favoriteCategoryList[
                                                              index]
                                                          .totalVideo,
                                                      text: videoProvider
                                                          .favoriteCategoryList[
                                                              index]
                                                          .categoryName,
                                                      isMoreIcon: true),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const SizedBox(width: 8);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: categoryProvider.categoryGetData(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        AppString.allCategories,
                                        style: CustomTextStyle
                                            .txt14W700HintColor11,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.w),
                                      child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: 177,
                                            mainAxisSpacing: 1.w,
                                            crossAxisSpacing: 3.4.w,
                                            crossAxisCount: 2,
                                          ),
                                          itemCount:
                                              snapshot.data?.docs.length ?? 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            CategoryModel categoryModel =
                                                CategoryModel.fromJson(snapshot
                                                        .data!.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>);

                                            return GestureDetector(
                                              onTap: () async {
                                                Get.toNamed(
                                                  AppRouteString
                                                      .categoryVideosScreen,
                                                  arguments:
                                                      CategoryVideosArguments(
                                                    id: categoryModel
                                                        .categoryId,
                                                  ),
                                                );
                                                await FirebaseFirestore.instance
                                                    .collection("category")
                                                    .doc(categoryModel
                                                        .categoryId)
                                                    .update({
                                                  'total_view':
                                                      FieldValue.increment(1)
                                                });
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12),
                                                  child: AllCategoriesContainer(
                                                    titleText: categoryModel
                                                        .categoryName,
                                                    intTotalVideos:
                                                        categoryModel
                                                            .totalVideo,
                                                    image:
                                                        categoryModel.thumbnail,
                                                  )),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              } else {
                                return const CategoryScreenAllCategoriesShimmer();
                              }
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
