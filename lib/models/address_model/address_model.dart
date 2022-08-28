class CityModel {
  List<CityContent> content = [];

  CityModel.fromJson(Map<String, dynamic> json) {
    json['content'].forEach((element) {
      content.add(CityContent.fromJson(element));
    });
  }
}

class CityContent {
  int? id;
  String? cityName;

  CityContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['cityName'];
  }
}
