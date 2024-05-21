/// SecurityQuestionModel
class SecurityQuestionModel {
  int index;
  bool live;
  String questionId;
  String questionText;

  SecurityQuestionModel(
      {required this.index,
      required this.live,
      required this.questionId,
      required this.questionText});

  factory SecurityQuestionModel.fromJson(Map<String, dynamic> json) =>
      SecurityQuestionModel(
        index: json["index"],
        live: json["live"],
        questionId: json["questionId"],
        questionText: json["questionText"],
      );

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "live": live,
      "questionId": questionId,
      "questionText": questionText,
    };
  }
}
