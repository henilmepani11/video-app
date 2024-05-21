import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/category_screen/model/category_model.dart';
import 'package:video_app/screen/category_screen/view/category_shimmer_view.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';
import 'package:video_app/screen/favourite_screen/controller/favorite_provider.dart';
import 'package:video_app/screen/favourite_screen/view/favourite_shimmer_view.dart';
import 'package:video_app/screen/video_screen/controller/video_provider.dart';
import 'package:video_app/widget/custom_appbar.dart';
import 'package:video_app/widget/custom_pop_categories_container.dart';
import 'package:video_app/widget/custom_video_details_container.dart';
import 'package:video_app/widget/scroll_configuration.dart';
import 'package:video_app/widget/show_menu.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    initCallFunction();
    super.initState();
  }

  initCallFunction() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VideoProvider videoProvider = Provider.of(context, listen: false);
      FavoriteProvider favoriteProvider = Provider.of(context, listen: false);
      AppProvider appProvider = Provider.of(context, listen: false);
      videoProvider.getFavoriteCategories(context: context);
      favoriteProvider.getFavoriteVideo(context: context);
      appProvider.storeCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    VideoProvider videoProvider = Provider.of(context, listen: false);
    FavoriteProvider favoriteProvider = Provider.of(context, listen: false);
    AppProvider appProvider = Provider.of(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        leadingFunction: () {},
        centerTitle: true,
        title: Text(AppString.favorite,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<VideoProvider>(
                  builder: (context, value, child) => videoProvider
                              .favoriteCategoryLoader ==
                          true
                      ? const CategoryScreenFavouriteCategoriesShimmer()
                      : videoProvider.favoriteCategoryList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    AppString.favoriteCategories,
                                    style: CustomTextStyle.txt14W700HintColor11,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                SizedBox(
                                  height: 153,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        // videoController
                                        videoProvider
                                            .favoriteCategoryList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          Get.toNamed(
                                            AppRouteString.categoryVideosScreen,
                                            arguments: CategoryVideosArguments(
                                              id: videoProvider
                                                  .favoriteCategoryList[index]
                                                  .categoryId,
                                            ),
                                          );
                                          await FirebaseFirestore.instance
                                              .collection("category")
                                              .doc(videoProvider
                                                  .favoriteCategoryList[index]
                                                  .categoryId)
                                              .update({
                                            'total_view':
                                                FieldValue.increment(1)
                                          });
                                        },
                                        child: CustomPopularCategoriesContainer(
                                            onTapMore:
                                                (TapDownDetails details) {
                                              showPopupMenu(
                                                  onTap: () {
                                                    videoProvider.categoryDelete(
                                                        argumentCategory:
                                                            videoProvider
                                                                .favoriteCategoryList[
                                                                    index]
                                                                .categoryId,
                                                        context: context);

                                                    appProvider
                                                        .getUserProfile();

                                                    appProvider.getLocalData();
                                                  },
                                                  offset:
                                                      details.globalPosition,
                                                  context: context);
                                            },
                                            valueTrue: true,
                                            image: videoProvider
                                                .favoriteCategoryList[index]
                                                .thumbnail,
                                            totalVideo: videoProvider
                                                .favoriteCategoryList[index]
                                                .totalVideo,
                                            text: videoProvider
                                                .favoriteCategoryList[index]
                                                .categoryName,
                                            isMoreIcon: true),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(width: 8);
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Text(
                    AppString.likedVideos,
                    style: CustomTextStyle.txt14W700HintColor11,
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<FavoriteProvider>(
                  builder: (context, value, child) => favoriteProvider
                              .favoriteVideoLoader ==
                          true
                      ? const FavoriteVideoShimmer()
                      : favoriteProvider.favoriteVideoList.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    favoriteProvider.favoriteVideoList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRouteString.videoScreen,
                                            arguments: VideoArguments(
                                              categoryId: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .categoryId,
                                              index: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .index,
                                              videoId: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .videoId,
                                              videoLink: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .videoLink,
                                            ));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          width: double.infinity,
                                          color: AppColor.backgroundColor20,
                                          child: CustomVideoDetailsContainer(
                                              onTapMore:
                                                  (TapDownDetails details) {
                                                showPopupMenu1(
                                                    offset:
                                                        details.globalPosition,
                                                    context: context,
                                                    onTap: () {
                                                      favoriteProvider
                                                          .deleteFavoriteVideo(
                                                              argumentVideoId:
                                                                  favoriteProvider
                                                                      .favoriteVideoList[
                                                                          index]
                                                                      .videoId,
                                                              context: context);

                                                      appProvider
                                                          .getUserProfile();

                                                      appProvider
                                                          .getLocalData();
                                                    });
                                              },
                                              valueTrue: true,
                                              fav: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .totalFavorite,
                                              view: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .totalView,
                                              image: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .thumbnail,
                                              titleText: favoriteProvider
                                                  .favoriteVideoList[index]
                                                  .videoName,
                                              isMoreIcon: true),
                                        ),
                                      ));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(height: 3);
                                },
                              ),
                            )
                          : Expanded(
                              child: Center(
                                  child: Text(
                                AppString.noLikedVideo,
                                style: CustomTextStyle.txt14W700HintColor11
                                    .copyWith(fontSize: 15),
                              )),
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
