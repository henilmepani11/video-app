class CategoryModel {
  int index;
  bool live;
  String categoryName;
  String categoryId;
  String thumbnail;
  int totalFavorite;
  int totalVideo;
  int totalView;

  CategoryModel({
    required this.index,
    required this.live,
    required this.categoryName,
    required this.categoryId,
    required this.thumbnail,
    required this.totalFavorite,
    required this.totalVideo,
    required this.totalView,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        index: json["index"],
        live: json["live"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        thumbnail: json["thumbnail"],
        totalFavorite: json["total_favorite"],
        totalVideo: json["total_video"],
        totalView: json["total_view"],
      );

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "live": live,
      "category_name": categoryName,
      "category_id": categoryId,
      "thumbnail": thumbnail,
      "total_favorite": totalFavorite,
      "total_video": totalVideo,
      "total_view": totalView,
    };
  }
}

class CategoryVideosArguments {
  final String? id;

  CategoryVideosArguments({
    this.id,
  });
}
