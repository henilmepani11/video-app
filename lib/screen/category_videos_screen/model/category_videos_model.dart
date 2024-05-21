class CategoryVideosModel {
  int? index;
  bool? live;
  String? categoryName;
  String? categoryId;
  String? thumbnail;
  int? totalFavorite;
  int? totalView;
  String? videoId;
  String? videoLink;
  String? videoName;

  CategoryVideosModel(
      {required this.index,
      required this.live,
      required this.categoryName,
      required this.categoryId,
      required this.thumbnail,
      required this.totalFavorite,
      required this.totalView,
      required this.videoId,
      required this.videoLink,
      required this.videoName});

  factory CategoryVideosModel.fromJson(Map<String, dynamic> json) =>
      CategoryVideosModel(
        index: json["index"],
        live: json["live"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        thumbnail: json["thumbnail"],
        totalFavorite: json["total_favorite"],
        totalView: json["total_view"],
        videoId: json["video_id"],
        videoLink: json["video_link"],
        videoName: json["video_name"],
      );

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "live": live,
      "category_name": categoryName,
      "category_id": categoryId,
      "thumbnail": thumbnail,
      "total_favorite": totalFavorite,
      "total_view": totalView,
      "video_id": videoId,
      "video_link": videoLink,
      "video_name": videoName,
    };
  }
}

class VideoArguments {
  String? categoryId;
  String? videoId;
  String? videoLink;
  int? index;

  VideoArguments({
    this.index,
    this.videoId,
    this.categoryId,
    this.videoLink,
  });
}
