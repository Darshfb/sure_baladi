class HomeModel{
  List<ProductHomeModel> content = [];
  int? totalPages;
  int? totalElements;
  bool? last;

  HomeModel.fromJson(Map<String, dynamic> json){
    json['content'].forEach((element){
      content.add(ProductHomeModel.fromJson(element));
    });
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
  }

}

class ProductHomeModel {
  int? id;
  String? productName;
  num? price;
  bool? available;
  String? quantityType;
  num? maximumQuantity;
  num? minimumQuantity;
  String? descriptionAr;
  String? descriptionEn;
  num? quantityIncrement;
  String? productImage;

  ProductHomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    price = json['price'];
    available = json['available'];
    quantityType = json['quantityType'];
    maximumQuantity = json['maximumQuantity'];
    minimumQuantity = json['minimumQuantity'];
    descriptionAr = json['descriptionAr'];
    descriptionEn = json['descriptionEn'];
    quantityIncrement = json['quantityIncrement'];
    productImage = json['productImage'];
  }
}
