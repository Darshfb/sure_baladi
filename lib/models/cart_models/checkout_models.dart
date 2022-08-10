import 'dart:convert';
  List<AddressContent> addressContent(String str) => List<AddressContent>.from(json.decode(str).map((x) => AddressContent.fromJson(x)));

class AddressModel {
  List<AddressContent> content = [];

  AddressModel.fromJson(Map<String, dynamic> json) {
    json['content'].forEach((element) {
      content.add(AddressContent.fromJson(element));
    });
  }
}

class AddressContent {
  int? id;
  String? country;
  String? districtNameAr;
  String? street;
  String? cityNameAr;

  AddressContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    districtNameAr = json['districtNameAr'];
    street = json['street'];
    cityNameAr = json['cityNameAr'];
  }
}
