import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:video_app/app_controller/app_provider.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';
import 'package:video_app/widget/custom_toast.dart';

class FavoriteProvider extends ChangeNotifier {
  /// favorite Video
  favoriteVideo({argumentVideoId, context}) async {
    AppProvider appProvider = Provider.of(context, listen: false);
    if ((appProvider.userSignUpModel!.likedVideo ?? [])
        .any((element) => element == argumentVideoId)) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(appProvider.userSignUpModel?.id)
          .update(
        {
          'likedVideo': FieldValue.arrayRemove([argumentVideoId]),
          "updated_at": DateTime.now().toString()
        },
      );
      await FirebaseFirestore.instance
          .collection("video")
          .doc(argumentVideoId)
          .update({'total_favorite': FieldValue.increment(-1)});

      favoriteVideoList.remove(argumentVideoId);
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(appProvider.userSignUpModel?.id)
          .update(
        {
          'likedVideo': FieldValue.arrayUnion([argumentVideoId]),
          "updated_at": DateTime.now().toString()
        },
      );
      await FirebaseFirestore.instance
          .collection("video")
          .doc(argumentVideoId)
          .update({'total_favorite': FieldValue.increment(1)});
    }

    appProvider.getUserProfile();

    appProvider.getLocalData();
    await getFavoriteVideo(context: context);
    notifyListeners();
  }

  /// favoriteVideo delete
  deleteFavoriteVideo({argumentVideoId, context}) async {
    AppProvider appProvider = Provider.of(context, listen: false);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(appProvider.userSignUpModel?.id)
        .update(
      {
        'likedVideo': FieldValue.arrayRemove([argumentVideoId]),
        "updated_at": DateTime.now().toString()
      },
    );
    await FirebaseFirestore.instance
        .collection("video")
        .doc(argumentVideoId)
        .update({'total_favorite': FieldValue.increment(-1)});
    favoriteVideoList.remove(argumentVideoId);
    customToast(message: AppString.likedVideoDelete);

    appProvider.getUserProfile();

    appProvider.getLocalData();
    await getFavoriteVideo(context: context);

    notifyListeners();
  }

  /// getFavoriteVideo
  List<CategoryVideosModel> favoriteVideoList = [];
  bool favoriteVideoLoader = false;
  getFavoriteVideo({context}) async {
    AppProvider appProvider = Provider.of(context, listen: false);
    try {
      favoriteVideoLoader = true;
      notifyListeners();

      favoriteVideoList.clear();
      for (var element in appProvider.userSignUpModel?.likedVideo ?? []) {
        final querySnapshot1 = await FirebaseFirestore.instance
            .collection("video")
            .where("live", isEqualTo: true)
            .where("video_id", isEqualTo: element)
            .get();

        favoriteVideoList.addAll(querySnapshot1.docs
            .map((e) => CategoryVideosModel(
                  live: e.get("live"),
                  index: e.get("index"),
                  categoryName: e.get("category_name"),
                  categoryId: e.get("category_id"),
                  thumbnail: e.get("thumbnail"),
                  totalFavorite: e.get("total_favorite"),
                  totalView: e.get("total_view"),
                  videoId: e.get("video_id"),
                  videoLink: e.get("video_link"),
                  videoName: e.get("video_name"),
                ))
            .toList());
      }
      favoriteVideoLoader = false;

      notifyListeners();
    } catch (e) {
      favoriteVideoLoader = false;
      notifyListeners();

      print("getFavoriteVideo error:$e");
    }
  }
}
