import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:numeral/numeral.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_assets.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/screen/category_videos_screen/controller/category_video_provider.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';
import 'package:video_app/screen/favourite_screen/controller/favorite_provider.dart';
import 'package:video_app/screen/video_screen/controller/video_provider.dart';
import 'package:video_app/screen/video_screen/view/video_shimmer.dart';
import 'package:video_app/widget/custom_video_details_container.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoArguments args = Get.arguments;

  @override
  void initState() {
    VideoProvider videoProvider = Provider.of(context, listen: false);
    videoProvider.getReportVideos();
    videoProvider.remainingVideo(
        categoryId: args.categoryId, index: args.index);
    videoProvider.myVideoId = args.videoId;
    videoProvider.youtubeVideos(
        argsVideoId: args.videoId, argsVideoLink: args.videoLink);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryVideoProvider categoryVideoProvider =
        Provider.of(context, listen: false);
    VideoProvider videoProvider = Provider.of(context, listen: false);
    FavoriteProvider favoriteProvider = Provider.of(context, listen: false);
    AppProvider appProvider = Provider.of(context, listen: false);
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        progressColors: ProgressBarColors(
            bufferedColor: AppColor.titleColor,
            handleColor: AppColor.primaryColor,
            backgroundColor: AppColor.primaryColor,
            playedColor: AppColor.primaryColor),
        onEnded: (data) async {
          videoProvider.onEndVideo();
        },
        controller: videoProvider.youtubePlayerController!,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    player,
                    IconButton(
                      splashColor: AppColor.transparent,
                      highlightColor: AppColor.transparent,
                      icon: SvgPicture.asset(AppAssets.backArrow),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                Consumer<VideoProvider>(
                  builder: (context, value, child) => StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("video")
                          .doc(videoProvider.myVideoId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          CategoryVideosModel categoryVideosModel =
                              CategoryVideosModel.fromJson(
                                  snapshot.data?.data() ?? {});
                          return Container(
                            padding: const EdgeInsets.only(top: 21, bottom: 16),
                            color: AppColor.primaryColor.withOpacity(0.1),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categoryVideosModel.videoName ?? "",
                                    style: CustomTextStyle
                                        .txt11W600HintColorRoboto
                                        .copyWith(
                                            color: AppColor.textFieldHintColor1,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 1.3.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          "${Numeral(categoryVideosModel.totalView ?? 0).format(fractionDigits: 0)}\t${AppString.views}",
                                          style: CustomTextStyle
                                              .txt14W600HintColorRoboto
                                              .copyWith(
                                                  color: AppColor
                                                      .linkHereTextField),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          "${Numeral(categoryVideosModel.totalFavorite ?? 0).format(fractionDigits: 0)}\t${AppString.fav}",
                                          style: CustomTextStyle
                                              .txt14W600HintColorRoboto
                                              .copyWith(
                                                  color: AppColor
                                                      .linkHereTextField),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          favoriteProvider.favoriteVideo(
                                              argumentVideoId:
                                                  categoryVideosModel.videoId,
                                              context: context);
                                          appProvider.getUserProfile();
                                          appProvider.getLocalData();
                                        },
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 0.25.h),
                                            child: (appProvider.userSignUpModel
                                                            ?.likedVideo ??
                                                        [])
                                                    .any((element) =>
                                                        element ==
                                                        videoProvider.myVideoId)
                                                ? SvgPicture.asset(
                                                    AppAssets.videoThumbBlue,
                                                    height: 2.3.h)
                                                : SvgPicture.asset(
                                                    AppAssets.videoThumb,
                                                    height: 2.3.h)),
                                      ),
                                      const SizedBox(width: 40),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.w),
                                        child: GestureDetector(
                                          onTap: () async {
                                            videoProvider.reportTapFunction(
                                                categoryVideosModel:
                                                    categoryVideosModel,
                                                context: context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                left: 10,
                                                right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(27),
                                                border: Border.all(
                                                    color:
                                                        AppColor.primaryColor,
                                                    width: 1)),
                                            child: Row(
                                              children: [
                                                videoProvider.reportVideosList
                                                        .any((element) =>
                                                            element.videoId ==
                                                            categoryVideosModel
                                                                .videoId)
                                                    ? Icon(Icons.report,
                                                        color: AppColor
                                                            .primaryColor)
                                                    : Icon(
                                                        Icons
                                                            .report_gmailerrorred,
                                                        color: AppColor.white),
                                                const SizedBox(width: 6),
                                                videoProvider.reportVideosList
                                                        .any((element) =>
                                                            element.videoId ==
                                                            categoryVideosModel
                                                                .videoId)
                                                    ? Text(
                                                        AppString.videoReported,
                                                        style: CustomTextStyle
                                                            .txt10boldWhite
                                                            .copyWith(
                                                                fontFamily:
                                                                    AppFontFamily
                                                                        .roboto,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 15),
                                                      )
                                                    : Text(
                                                        AppString.reportVideo,
                                                        style: CustomTextStyle
                                                            .txt10boldWhite
                                                            .copyWith(
                                                                fontFamily:
                                                                    AppFontFamily
                                                                        .roboto,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 15),
                                                      ),
                                                const SizedBox(width: 6),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 1.3.h),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.w),
                                    child: Container(
                                      height: 0.10.h,
                                      width: double.infinity,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 1.5.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              categoryVideosModel
                                                      .categoryName ??
                                                  "",
                                              style: CustomTextStyle
                                                  .txt14W600HintColor1
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColor
                                                          .textFieldHintColor1)),
                                          SizedBox(height: 1.2.h),
                                          Text(AppString.category,
                                              style: CustomTextStyle
                                                  .txt14W600HintColorRoboto),
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.w),
                                        child: GestureDetector(
                                          onTap: () async {
                                            videoProvider
                                                .favoriteCategoryTapFunction(
                                                    context: context,
                                                    appProvider: appProvider,
                                                    categoryVideoProvider:
                                                        categoryVideoProvider,
                                                    categoryVideosModel:
                                                        categoryVideosModel);
                                          },
                                          child: Consumer<AppProvider>(
                                            builder: (context, value, child) =>
                                                Container(
                                              padding: const EdgeInsets.only(
                                                  top: 12,
                                                  bottom: 11,
                                                  left: 11,
                                                  right: 11),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(27),
                                                  border: Border.all(
                                                      color:
                                                          AppColor.primaryColor,
                                                      width: 1)),
                                              child: Row(
                                                children: [
                                                  appProvider
                                                          .storeLikedCategoryList
                                                          .contains(
                                                              categoryVideosModel
                                                                  .categoryId)
                                                      ? SvgPicture.asset(
                                                          AppAssets.heart2,
                                                          color: AppColor
                                                              .primaryColor,
                                                          height: 24,
                                                        )
                                                      : SvgPicture.asset(
                                                          AppAssets.like,
                                                          color: AppColor.white,
                                                          height: 24,
                                                        ),
                                                  const SizedBox(width: 6),
                                                  appProvider
                                                          .storeLikedCategoryList
                                                          .contains(
                                                              categoryVideosModel
                                                                  .categoryId)
                                                      ? Text(
                                                          AppString.favorite,
                                                          style: CustomTextStyle
                                                              .txt10boldWhite
                                                              .copyWith(
                                                                  fontFamily:
                                                                      AppFontFamily
                                                                          .roboto,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14),
                                                        )
                                                      : Text(
                                                          AppString.addToFav,
                                                          style: CustomTextStyle
                                                              .txt10boldWhite
                                                              .copyWith(
                                                                  fontFamily:
                                                                      AppFontFamily
                                                                          .roboto,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14),
                                                        ),
                                                  const SizedBox(width: 6),
                                                  if (appProvider
                                                      .storeLikedCategoryList
                                                      .contains(
                                                          categoryVideosModel
                                                              .categoryId))
                                                    SvgPicture.asset(
                                                        AppAssets.right,
                                                        height: 1.5.h)
                                                  else
                                                    const SizedBox()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const VideoDetailsShimmer();
                        }
                      }),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(AppString.uPNext,
                      style: CustomTextStyle.txt14W600HintColor1
                          .copyWith(fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Consumer<VideoProvider>(
                    builder: (context, value, child) => SizedBox(
                      height: 370,
                      child: videoProvider.myListVideo.isNotEmpty
                          ? FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("video")
                                  .where("video_id",
                                      whereIn: videoProvider.myListVideo)
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.separated(
                                    itemCount: snapshot.data?.docs.length ?? 0,
                                    itemBuilder: (context, index) {
                                      CategoryVideosModel categoryVideosModel =
                                          CategoryVideosModel.fromJson(
                                              snapshot.data?.docs[index].data()
                                                  as Map<String, dynamic>);
                                      return GestureDetector(
                                        onTap: () async {
                                          videoProvider.onTapPlayVideo(
                                              index: index,
                                              videoId:
                                                  categoryVideosModel.videoId,
                                              videoLink: categoryVideosModel
                                                  .videoLink);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          color: AppColor.backgroundColor20,
                                          child: CustomVideoDetailsContainer(
                                            valueTrue: true,
                                            fav: categoryVideosModel
                                                .totalFavorite,
                                            view: categoryVideosModel.totalView,
                                            image:
                                                categoryVideosModel.thumbnail,
                                            titleText:
                                                categoryVideosModel.videoName,
                                            isMoreIcon: false,
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(height: 1.5.h);
                                    },
                                  );
                                } else {
                                  return const VideoScreenShimmer();
                                }
                              })
                          : Center(
                              child: Text(AppString.noVideos,
                                  style: CustomTextStyle.txt14W700HintColor11
                                      .copyWith(fontSize: 15)),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
