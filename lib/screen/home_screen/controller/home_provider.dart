import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';
import 'package:video_app/screen/home_screen/model/popular_categories_model/get_popular_categeroies_model.dart';
import 'package:video_app/screen/home_screen/model/popular_categories_model/show_popular_categories_model.dart';
import 'package:video_app/screen/home_screen/model/popular_categories_video_model/get_popular_categories_video_model.dart';

class HomeProvider extends ChangeNotifier {
  List<GetPopularCategoriesModel> getPopularCategoriesList = [];
  List<ShowPopularCategoriesModel> showPopularCategoriesList = [];
  bool getPopularLoader = false;

  int sliderbox = 0;

  ///category view update
  categoryViewUpdate({categoryId}) async {
    await FirebaseFirestore.instance
        .collection("category")
        .doc(categoryId)
        .update({'total_view': FieldValue.increment(1)});
  }

  /// Popular Categories
  Future getPopularCategories() async {
    try {
      getPopularLoader = true;

      showPopularCategoriesList.clear();
      final querySnapshot = await FirebaseFirestore.instance
          .collection("popular_category")
          .where("live", isEqualTo: true)
          .get();

      getPopularCategoriesList = querySnapshot.docs
          .map(
            (e) => GetPopularCategoriesModel(
              live: e.get("live"),
              categoryId: e.get("category_id"),
            ),
          )
          .toList();

      for (var element in getPopularCategoriesList) {
        final querySnapshot1 = await FirebaseFirestore.instance
            .collection("category")
            .where("live", isEqualTo: true)
            .where("category_id", isEqualTo: element.categoryId)
            .get();

        showPopularCategoriesList.addAll(querySnapshot1.docs
            .map(
              (e) => ShowPopularCategoriesModel(
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
        getPopularLoader = false;

        notifyListeners();
      }
    } catch (e) {
      getPopularLoader = false;
      notifyListeners();
      print("getPopularCategories error:$e");
    }
  }

  /// homeScreen swiper
  List<GetPopularCategoriesVideoModel> getPopularCategoriesVideoList = [];
  List<CategoryVideosModel> showPopularCategoriesVideoList = [];
  bool isLoader = false;
  Future<void> getSwiper() async {
    try {
      isLoader = true;

      showPopularCategoriesVideoList.clear();
      final querySnapshot = await FirebaseFirestore.instance
          .collection("popular_video")
          .where("live", isEqualTo: true)
          .get();

      getPopularCategoriesVideoList = querySnapshot.docs
          .map(
            (e) => GetPopularCategoriesVideoModel(
              live: e.get("live"),
              videoId: e.get("video_id"),
            ),
          )
          .toList();

      for (var element in getPopularCategoriesVideoList) {
        final querySnapshot1 = await FirebaseFirestore.instance
            .collection("video")
            .where("live", isEqualTo: true)
            .where("video_id", isEqualTo: element.videoId)
            .get();

        showPopularCategoriesVideoList.addAll(querySnapshot1.docs
            .map(
              (e) => CategoryVideosModel(
                live: e.get("live"),
                categoryId: e.get("category_id"),
                categoryName: e.get("category_name"),
                totalView: e.get("total_view"),
                totalFavorite: e.get("total_favorite"),
                thumbnail: e.get("thumbnail"),
                index: e.get("index"),
                videoId: e.get("video_id"),
                videoLink: e.get("video_link"),
                videoName: e.get("video_name"),
              ),
            )
            .toList());

        notifyListeners();
      }
      isLoader = false;
      notifyListeners();
    } catch (e) {
      isLoader = false;

      notifyListeners();
    }
  }
}
