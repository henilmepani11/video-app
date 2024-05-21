class RecommendedModel {
  String? createdAt;
  String? id;
  String? userid;
  String? videoLink;

  RecommendedModel({
    this.createdAt,
    this.id,
    this.userid,
    this.videoLink,
  });

  factory RecommendedModel.fromJson(Map<String, dynamic> json) =>
      RecommendedModel(
        createdAt: json["created_at"],
        id: json["id"],
        userid: json["user_id"],
        videoLink: json["video_link"],
      );

  Map<String, dynamic> toJson() {
    return {
      "created_at": createdAt,
      "id": id,
      "user_id": userid,
      "video_link": videoLink,
    };
  }
}
