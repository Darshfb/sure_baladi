import 'dart:convert';
  // List<AddressContent> addressContent(String str) => List<AddressContent>.from(json.decode(str).map((x) => AddressContent.fromJson(x)));

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
  String? districtName;
  String? street;
  String? cityName;

  AddressContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    districtName = json['districtName'];
    street = json['street'];
    cityName = json['cityName'];
  }
}
