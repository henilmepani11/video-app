class ChipModel {
  String? name;
  String? id;
  String? interestId;

  ChipModel({this.name, this.id, this.interestId});

  factory ChipModel.fromJson(Map<String, dynamic> json) => ChipModel(
        id: json["id"],
        name: json["name"],
        interestId: json["interestId"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "interestId": interestId,
    };
  }
}
