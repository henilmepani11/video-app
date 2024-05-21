import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';

class CategoryVideoProvider extends ChangeNotifier {
  /// firebase category get
  List<CategoryVideosModel> categoryVideosList = [];
  bool isLoader = false;
  getCategoryVideos({categoryId}) async {
    try {
      categoryVideosList.clear();
      isLoader = true;
      final querySnapshot = await FirebaseFirestore.instance
          .collection("video")
          .where("live", isEqualTo: true)
          .where("category_id", isEqualTo: categoryId)
          .get();
      categoryVideosList = querySnapshot.docs.map(
        (e) {
          return CategoryVideosModel(
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
          );
        },
      ).toList();
      isLoader = false;
      notifyListeners();
    } catch (e) {
      isLoader = false;
      notifyListeners();
      print('getCategoryVideos: $e');
    }
  }
}
