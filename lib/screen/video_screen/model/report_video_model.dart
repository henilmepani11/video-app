class ReportVideoModel {
  String? createdAt;
  String? id;
  String? reportReason;
  String? userid;
  String? videoCategoryId;
  String? videoId;
  String? videoName;

  ReportVideoModel({
    this.createdAt,
    this.id,
    this.reportReason,
    this.userid,
    this.videoCategoryId,
    this.videoId,
    this.videoName,
  });

  factory ReportVideoModel.fromJson(Map<String, dynamic> json) =>
      ReportVideoModel(
        createdAt: json["created_at"],
        id: json["id"],
        reportReason: json["reported_reason"],
        userid: json["user_id"],
        videoCategoryId: json["video_category_id"],
        videoId: json["video_id"],
        videoName: json["video_name"],
      );

  Map<String, dynamic> toJson() {
    return {
      "created_at": createdAt,
      "id": id,
      "reported_reason": reportReason,
      "user_id": userid,
      "video_category_id": videoCategoryId,
      "video_id": videoId,
      "video_name": videoName,
    };
  }
}
