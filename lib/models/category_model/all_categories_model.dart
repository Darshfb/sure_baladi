class AllCategoriesModel {
  List<CategoriesContent> content = [];

  AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    json['content'].forEach((element) {
      content.add(CategoriesContent.fromJson(element));
    });
  }
}

class CategoriesContent {
  int? id;
  String? categoryNameAr;
  String? categoryNameEn;

  CategoriesContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryNameAr = json['categoryNameAr'];
    categoryNameEn = json['categoryNameEn'];
  }
}
