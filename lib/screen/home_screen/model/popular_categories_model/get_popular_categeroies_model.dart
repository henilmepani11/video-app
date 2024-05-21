class GetPopularCategoriesModel {
  bool live;
  String categoryId;

  GetPopularCategoriesModel({
    required this.live,
    required this.categoryId,
  });

  factory GetPopularCategoriesModel.fromJson(Map<String, dynamic> json) =>
      GetPopularCategoriesModel(
        live: json["live"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() {
    return {
      "live": live,
      "category_id": categoryId,
    };
  }
}
