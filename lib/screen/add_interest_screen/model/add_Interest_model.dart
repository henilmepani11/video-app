/// InterestModel
class AddInterestModel {
  int index;
  bool live;
  String interestId;
  String interestText;

  AddInterestModel(
      {required this.index,
      required this.live,
      required this.interestId,
      required this.interestText});

  factory AddInterestModel.fromJson(Map<String, dynamic> json) =>
      AddInterestModel(
        index: json["index"],
        live: json["live"],
        interestId: json["interestId"],
        interestText: json["interestText"],
      );

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "live": live,
      "interestId": interestId,
      "interestText": interestText,
    };
  }
}
