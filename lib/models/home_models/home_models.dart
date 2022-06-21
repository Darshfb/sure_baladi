/*
"id": 306,
            "productNameAr": "هوهوز بالحبة ",
            "productNameEn": "هوهوز بالحبة ",
            "price": 1.5,
            "productOffers": [],
            "productPictures": [
                {
                    "id": 290,
                    "fileName": "f4950fdb-feb8-42f5-9729-7935fade95d9.jpeg",
                    "fileSize": 183318,
                    "mainPicture": true
                }
            ],
            "featuredProduct": true,
            "available": true,
            "quantityType": "Kilo",
            "maximumQuantity": 100.0,
            "minimumQuantity": 1.0,
            "quantityIncrement": 1.0,
            "descriptionAr": "حبة ",
            "descriptionEn": null,
            "productImage": "https://souqashour.com:4433/Images/f4950fdb-feb8-42f5-9729-7935fade95d9.jpeg"
        }

 */

class HomeModel{
  List<ProductHomeModel> content = [];
  int? totalPages;

  HomeModel.fromJson(Map<String, dynamic> json){
    json['content'].forEach((element){
      content.add(ProductHomeModel.fromJson(element));
    });
    totalPages = json['totalPages'];
  }

}

class ProductHomeModel {
  int? id;
  String? productNameAr;
  String? productNameEn;
  dynamic price;
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
    productNameAr = json['productNameAr'];
    productNameEn = json['productNameEn'];
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
