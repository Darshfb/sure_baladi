class CategoryProductModel {
  List<CategoryProductContentModel> content = [];
  int? totalPages;
  int? totalElements;
  bool? last;
  bool? empty;

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    json['content'].forEach((element) {
      content.add(CategoryProductContentModel.fromJson(element));
    });
  }
}

class CategoryProductContentModel {
  int? id;
  String? productNameAr;
  String? productNameEn;
  num? price;
  bool? available;
  String? quantityType;
  String? descriptionAr;
  String? descriptionEn;
  String? productImage;

  CategoryProductContentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productNameAr = json['productNameAr'];
    productNameEn = json['productNameEn'];
    price = json['price'];
    available = json['available'];
    quantityType = json['quantityType'];
    descriptionAr = json['descriptionAr'];
    descriptionEn = json['descriptionEn'];
    productImage = json['productImage'];
  }
}
