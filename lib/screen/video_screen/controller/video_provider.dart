import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/route/route_constant.dart';
import 'package:video_app/screen/category_screen/model/category_model.dart';
import 'package:video_app/screen/video_screen/model/report_video_model.dart';
import 'package:video_app/widget/custom_toast.dart';
import 'package:video_app/widget/show_dialog.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoProvider extends ChangeNotifier {
  final TextEditingController reportSubmitController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  List<String>? reportVideoId;
  bool isLoader = false;

  /// youtube Videos
  String? videoId;
  YoutubePlayerController? youtubePlayerController;
  youtubeVideos({argsVideoLink, argsVideoId}) async {
    videoId = YoutubePlayer.convertUrlToId(argsVideoLink);
    youtubePlayerController = null;
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId.toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    await FirebaseFirestore.instance
        .collection("video")
        .doc(argsVideoId)
        .update({'total_view': FieldValue.increment(1)});
  }

  ///report tap function
  reportTapFunction({categoryVideosModel, context}) {
    if (!reportVideosList
        .any((element) => element.videoId == categoryVideosModel.videoId)) {
      showAlertDialog(
          loader: isLoader,
          context: context,
          controller: reportSubmitController,
          formkey: formkey,
          onTapFunction: () async {
            await reportVideo(
                videoId: categoryVideosModel.videoId,
                videoName: categoryVideosModel.videoName,
                videoCategoryId: categoryVideosModel.categoryId,
                context: context);

            getReportVideos();
          });
    }
  }

  ///favorite category tap function
  favoriteCategoryTapFunction(
      {appProvider, categoryVideosModel, categoryVideoProvider, context}) {
    if (categoryVideosModel.categoryId?.isNotEmpty ?? false) {
      if (appProvider.storeLikedCategoryList
          .contains(categoryVideosModel.categoryId)) {
        appProvider.storeLikedCategoryList
            .remove(categoryVideosModel.categoryId);
      } else {
        appProvider.storeLikedCategoryList.add(categoryVideosModel.categoryId);
      }
      favoriteCategory(
          argumentCategory: categoryVideosModel.categoryId, context: context);

      appProvider.getUserProfile();
      appProvider.getLocalData();
      categoryVideoProvider.notifyListeners();
    }
  }

  /// video end
  List myListVideo = [];
  onEndVideo() {
    if (myListVideo.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("video")
          .doc(myListVideo[0])
          .get()
          .then((value) {
        youtubePlayerController?.load(
            YoutubePlayer.convertUrlToId(value.data()?["video_link"]) ?? '');
      });
      myVideoId = myListVideo[0];
      myListVideo.remove(myListVideo[0]);

      notifyListeners();
    } else {
      Get.back();
    }
  }

  ///tap_video and play
  String? myVideoId;
  onTapPlayVideo({videoLink, videoId, index}) {
    youtubePlayerController
        ?.load(YoutubePlayer.convertUrlToId(videoLink) ?? "");
    myVideoId = videoId;
    myListVideo.removeRange(0, index + 1);

    notifyListeners();
  }

  /// remaining video
  remainingVideo({categoryId, index}) {
    FirebaseFirestore.instance
        .collection("video")
        .where("category_id", isEqualTo: categoryId)
        .where("index", isGreaterThan: index)
        .get()
        .then((value) {
      myListVideo = value.docs.map((e) => e.data()["video_id"]).toList();
    });
  }

  /// video report
  reportVideo({videoId, videoCategoryId, videoName, context}) async {
    try {
      AppProvider appProvider = Provider.of(context, listen: false);
      isLoader = true;
      notifyListeners();

      DocumentReference doc =
          FirebaseFirestore.instance.collection('reported_video').doc();

      final reportVideoModel = ReportVideoModel(
          videoId: videoId,
          reportReason: reportSubmitController.text,
          videoCategoryId: videoCategoryId,
          videoName: videoName,
          id: doc.id,
          createdAt: DateTime.now().toString(),
          userid: appProvider.userSignUpModel?.id);
      doc.set(reportVideoModel.toJson());
      Get.toNamed(AppRouteString.videoScreen);
      isLoader = false;
      customToast(message: "Report Video successfully");

      notifyListeners();
    } catch (e) {
      isLoader = false;
      notifyListeners();
      print("reportVideo : $e");
    }
  }

  /// firebase get report collection
  List<ReportVideoModel> reportVideosList = [];
  getReportVideos() async {
    try {
      reportVideosList.clear();
      final querySnapshot =
          await FirebaseFirestore.instance.collection("reported_video").get();
      reportVideosList = querySnapshot.docs.map(
        (e) {
          return ReportVideoModel(
            videoCategoryId: e.get("video_category_id"),
            reportReason: e.get("reported_reason"),
            videoId: e.get("video_id"),
            id: e.get("id"),
            createdAt: e.get("created_at"),
            userid: e.get("user_id"),
            videoName: e.get("video_name"),
          );
        },
      ).toList();
      notifyListeners();
    } catch (e) {
      print('getReportVideos: $e');
    }
  }

  /// favoriteCategory firebase code
  favoriteCategory({argumentCategory, context}) async {
    AppProvider appProvider = Provider.of(context, listen: false);
    if ((appProvider.userSignUpModel?.userFavoriteCategory ?? [])
        .any((element) => element == argumentCategory)) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(appProvider.userSignUpModel?.id)
          .update(
        {
          'userFavoriteCategory': FieldValue.arrayRemove([argumentCategory]),
          "updated_at": DateTime.now().toString()
        },
      );
      favoriteCategoryList.remove(argumentCategory);
      await FirebaseFirestore.instance
          .collection("category")
          .doc(argumentCategory)
          .update({'total_favorite': FieldValue.increment(-1)});
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(appProvider.userSignUpModel?.id)
          .update(
        {
          'userFavoriteCategory': FieldValue.arrayUnion([argumentCategory]),
          "updated_at": DateTime.now().toString()
        },
      );
      await FirebaseFirestore.instance
          .collection("category")
          .doc(argumentCategory)
          .update({'total_favorite': FieldValue.increment(1)});
    }
    appProvider.getUserProfile();
    appProvider.getLocalData();

    await getFavoriteCategories(context: context);
    notifyListeners();
  }

  /// category Delete
  categoryDelete({argumentCategory, context}) async {
    AppProvider appProvider = Provider.of(context, listen: false);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(appProvider.userSignUpModel?.id)
        .update(
      {
        'userFavoriteCategory': FieldValue.arrayRemove([argumentCategory]),
        "updated_at": DateTime.now().toString()
      },
    );
    await FirebaseFirestore.instance
        .collection("category")
        .doc(argumentCategory)
        .update({'total_favorite': FieldValue.increment(-1)});
    favoriteCategoryList.remove(argumentCategory);

    appProvider.storeLikedCategoryList.remove(argumentCategory);
    customToast(message: AppString.favoriteCategoryDelete);

    appProvider.getUserProfile();

    appProvider.getLocalData();
    await getFavoriteCategories(context: context);
    notifyListeners();
  }

  ///get fav category in firebase
  List<CategoryModel> favoriteCategoryList = [];
  bool favoriteCategoryLoader = false;
  getFavoriteCategories({context}) async {
    AppProvider appProvider = Provider.of(context, listen: false);
    try {
      favoriteCategoryLoader = true;

      notifyListeners();

      favoriteCategoryList.clear();
      for (var element
          in appProvider.userSignUpModel?.userFavoriteCategory ?? []) {
        final querySnapshot1 = await FirebaseFirestore.instance
            .collection("category")
            .where("live", isEqualTo: true)
            .where("category_id", isEqualTo: element)
            .get();

        favoriteCategoryList.addAll(querySnapshot1.docs
            .map(
              (e) => CategoryModel(
                live: e.get("live"),
                categoryId: e.get("category_id"),
                categoryName: e.get("category_name"),
                totalView: e.get("total_view"),
                totalFavorite: e.get("total_favorite"),
                thumbnail: e.get("thumbnail"),
                index: e.get("index"),
                totalVideo: e.get("total_video"),
              ),
            )
            .toList());
      }
      favoriteCategoryLoader = false;

      notifyListeners();
    } catch (e) {
      favoriteCategoryLoader = false;
      notifyListeners();

      print("getFavoriteCategories error:$e");
    }
  }
}
