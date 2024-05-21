class GetPopularCategoriesVideoModel {
  bool live;
  String videoId;

  GetPopularCategoriesVideoModel({
    required this.live,
    required this.videoId,
  });

  factory GetPopularCategoriesVideoModel.fromJson(Map<String, dynamic> json) =>
      GetPopularCategoriesVideoModel(
        live: json["live"],
        videoId: json["video_id"],
      );

  Map<String, dynamic> toJson() {
    return {
      "live": live,
      "video_id": videoId,
    };
  }
}
