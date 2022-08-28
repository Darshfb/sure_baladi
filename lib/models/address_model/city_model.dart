class DistrictModel {
  int? id;
  String? districtName;

  DistrictModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['districtName'];
  }
}
