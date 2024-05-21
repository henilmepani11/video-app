class UserSignUpModel {
  String? email;
  String? password;
  String? id;
  String? fullName;
  String? imagePath;
  String? securityQuestionId;
  String? securityQuestionAnswer;
  String? createdAt;
  String? updatedAt;
  List? interestList;
  List? userFavoriteCategory;
  List? likedVideo;

  UserSignUpModel({
    this.email,
    this.id,
    this.imagePath,
    this.fullName,
    this.securityQuestionId,
    this.securityQuestionAnswer,
    this.createdAt,
    this.updatedAt,
    this.interestList,
    this.userFavoriteCategory,
    this.likedVideo,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) =>
      UserSignUpModel(
        email: json["email"],
        id: json["id"],
        imagePath: json["imagePath"],
        fullName: json["fullName"],
        securityQuestionId: json["security_question_id"],
        securityQuestionAnswer: json["security_question_ans"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        interestList: json["interest"] ?? [],
        userFavoriteCategory: json["userFavoriteCategory"] ?? [],
        likedVideo: json["likedVideo"] ?? [],
      );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "id": id,
      "imagePath": imagePath,
      "fullName": fullName,
      "security_question_id": securityQuestionId,
      "security_question_ans": securityQuestionAnswer,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "interest": interestList,
      "userFavoriteCategory": userFavoriteCategory,
      "likedVideo": likedVideo,
    };
  }
}
