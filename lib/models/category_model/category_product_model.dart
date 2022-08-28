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
  String? productName;
  num? price;
  bool? available;
  String? quantityType;
  String? description;
  String? productImage;

  CategoryProductContentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    price = json['price'];
    available = json['available'];
    quantityType = json['quantityType'];
    description = json['descriptionAr'];
    productImage = json['productImage'];
  }
}
