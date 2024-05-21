import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_app/screen/category_videos_screen/model/category_videos_model.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  /// search firebase query
  List<CategoryVideosModel> searchList = [];
  bool isLoader = false;
  searchVideos({String? query}) async {
    try {
      isLoader = true;
      final querySnapshot = await FirebaseFirestore.instance
          .collection("video")
          .where("live", isEqualTo: true)
          .where("search_keyword", arrayContains: query)
          .get();

      searchList = querySnapshot.docs.map(
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
      print('searchVideos: $e');
    }
  }
}
