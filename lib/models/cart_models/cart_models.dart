class CartModels {
  List<CartItemsModel> cartItems = [];
  num? totalBeforeVat;
  num? total;
  num? vat;

  CartModels.fromJson(Map<String, dynamic> json) {
    json['cartItems'].forEach((element) {
      cartItems.add(CartItemsModel.fromJson(element));
    });
    totalBeforeVat = json['totalBeforeVat'];
    total = json['total'];
    vat = json['vat'];
  }
}

class CartItemsModel {
  num? quantity;
  num? price;
  ProductCartItemModel? product;

  CartItemsModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    product = json['product'] != null
        ? ProductCartItemModel.fromJson(json['product'])
        : null;
  }
}

class ProductCartItemModel {
  int? id;
  String? productNameAr;
  String? productNameEn;
  String? productImage;

  ProductCartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productNameAr = json['productNameAr'];
    productNameEn = json['productNameEn'];
    productImage = json['productImage'];
  }
}

/*
                "id": 325,
                "productNameAr": "تايجر\" شطه وليمون",
                "productNameEn": "تايجر\" شطه وليمون",
                "price": 5.0,
  */
